from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
import scipy.io
import cv2
import json
import base64

app = Flask(__name__)
app.debug = True

# Global variables
IMG_H = 320
IMG_W = 416
NUM_CLASSES = 17
CLASSES = None
COLORMAP = None
model = None

# model path using the relative path
current_model_path = '/home/ron/xcodes/dt_docker/segmentation_model.h5'

# food color map path using the relative path
current_food_map_path = '/home/ron/xcodes/dt_docker/foods_colormap.mat'

def grayscale_to_rgb(mask, classes, colormap):
    h, w, _ = mask.shape
    mask = mask.astype(np.int32)
    output = []

    for i, pixel in enumerate(mask.flatten()):
        output.append(colormap[pixel])

    output = np.reshape(output, (h, w, 3))
    return output

import matplotlib.pyplot as plt

import matplotlib.pyplot as plt

def save_results(image, pred, save_image_path):
    h, w, _ = image.shape
    line = np.ones((h, 10, 3)) * 255

    pred = np.expand_dims(pred, axis=-1)
    pred_rgb = grayscale_to_rgb(pred, CLASSES, COLORMAP)
    resized_mask = cv2.resize(pred_rgb, (w,h))

    cat_images = np.concatenate([image, line, resized_mask], axis=1)

    # Save the concatenated image to the disk
    if cv2.imwrite(save_image_path, cat_images):
        print(f"Concatenated image saved successfully at: {save_image_path}")
    else:
        print("Error: Failed to save concatenated image.")

def getPercentages(mask, colormap, class_list):
    mask = np.expand_dims(mask, axis=-1)
    mask = grayscale_to_rgb(mask, CLASSES, COLORMAP)
    class_counts = np.zeros(len(class_list))

    # Convert colormap to a dictionary for efficient lookup
    colormap_dict = {tuple(colormap[i]): i for i in range(len(colormap))}

    # Iterate over each pixel in the segmentation mask
    for row in mask:
        for pixel in row:
            if isinstance(pixel, float):
                pixel = [pixel]
            pixel_tuple = tuple(pixel)
            if pixel_tuple in colormap_dict:
                class_index = colormap_dict[pixel_tuple]
                class_counts[class_index] += 1

    # Calculate percentages
    total_pixels = np.sum(class_counts)
    class_percentages = [count / total_pixels * 100 for count in class_counts]

    return class_percentages

def image_to_base64(image):
    _, buffer = cv2.imencode('.jpg', image)
    return base64.b64encode(buffer).decode('utf-8')

def getConfidenceScores(mask, colormap, class_percentages):
    confidence_scores = []
    for label, percentage in zip(CLASSES, class_percentages):
        if label != 'background' and percentage >= 0.3:
            class_mask = (mask == CLASSES.index(label))
            class_pixels = mask[class_mask]

            if len(class_pixels) == 0:
                confidence = 0.0
            else:
                confidence = np.mean(class_pixels)

            confidence_scores.append({
                'label': label,
                'percentage': float(percentage),
                'confidence_score': float(confidence)
            })

            # Add the processed image to the confidence_scores list
            processed_image_base64 = image_to_base64((mask * 255.0).astype(np.uint8))
            confidence_scores.append({'processed_image': processed_image_base64})

    return confidence_scores

def load_model():
    global CLASSES, COLORMAP, model

    # Load the model
    model_path = current_model_path
    model = tf.keras.models.load_model(model_path)

    # Load the colormap
    mat_path = current_food_map_path
    colormap = scipy.io.loadmat(mat_path)["colormap"]
    colormap = colormap * 256
    colormap = colormap.astype(np.uint8)
    classes = ['background','1203', '1206', '3001', '30001', '30091', '801041', '802002', '805002', '806122', '806130', '808186', '814021', '814024', '814025', '830002', '4006']
    COLORMAP = colormap
    CLASSES = classes


@app.route('/', methods=['POST'])
def index():
    if 'image' not in request.files:
        return jsonify({'error': 'No image file uploaded'}), 400

    image_file = request.files['image']
    
    if image_file.filename == '':
        return jsonify({'error': 'No image file uploaded'}), 400

    allowed_extensions = ['jpg', 'jpeg']
    if not any(image_file.filename.lower().endswith(ext) for ext in allowed_extensions):
        return jsonify({'error': 'Invalid file format. Please upload a JPG'}), 400

    try:
        image = cv2.imdecode(np.fromstring(image_file.read(), np.uint8), cv2.IMREAD_COLOR)
        image = cv2.resize(image, (IMG_W, IMG_H))
        image = image / 255.0
        image = np.expand_dims(image, axis=0)

        pred = model.predict(image, verbose=0)[0]
        pred = np.argmax(pred, axis=-1)
        pred = pred.astype(np.float32)

        save_results(image[0] * 255.0, pred, '/home/ron/xcodes/dt_docker/image_masks/image_1.jpg')

        class_percentages = getPercentages(pred, COLORMAP, CLASSES)
        confidence_scores = getConfidenceScores(pred, CLASSES, class_percentages)

          # Create the JSON response with labels, percentages, and confidence scores
        response = {
            'segmentation_result': confidence_scores
        }

        # Print the JSON response just before sending
        print('JSON Response:', json.dumps(response, indent=4))

        return jsonify(response), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == "__main__":
    load_model()
    app.run('localhost', 5001)