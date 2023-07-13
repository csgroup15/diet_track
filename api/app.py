from flask import Flask, render_template, request
import tensorflow as tf
import numpy as np
import scipy.io
import cv2

app = Flask(__name__, template_folder='')

# Global variables
IMG_H = 320
IMG_W = 416
NUM_CLASSES = 17
CLASSES = None
COLORMAP = None
model = None

# model path using the relative path
current_model_path = ('/model_files/segmentation_model.h5')

# food color map path using the relative path
current_food_map_path = ('/model_files/foods_colormap.mat')

def grayscale_to_rgb(mask, classes, colormap):
    h, w, _ = mask.shape
    mask = mask.astype(np.int32)
    output = []

    for i, pixel in enumerate(mask.flatten()):
        output.append(colormap[pixel])

    output = np.reshape(output, (h, w, 3))
    return output

def save_results(image, pred):
    h, w, _ = image.shape

    pred = np.expand_dims(pred, axis=-1)
    pred = grayscale_to_rgb(pred, CLASSES, COLORMAP)
    resized_mask = cv2.resize(pred, (w,h))
    # visualize(image,resized_mask)

    # cat_images = np.concatenate([image, line, mask, line, pred], axis=1)
    # cv2.imwrite(save_image_path, cat_images)

def getPercentages(mask,colormap,class_list):
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

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Check if an image file was uploaded
        if 'image' not in request.files:
            return render_template('index.html', error='No image file uploaded')

        image_file = request.files['image']
        
        # Check if the file is empty
        if image_file.filename == '':
            return render_template('index.html', error='No image file uploaded')

        # Check if the file is allowed
        allowed_extensions = ['jpg', 'jpeg']
        if not any(image_file.filename.lower().endswith(ext) for ext in allowed_extensions):
            return render_template('index.html', error='Invalid file format. Please upload a JPG')

        # Read the uploaded image
        image = cv2.imdecode(np.fromstring(image_file.read(), np.uint8), cv2.IMREAD_COLOR)
        image = cv2.resize(image, (IMG_W, IMG_H))
        image = image / 255.0
        image = np.expand_dims(image, axis=0)

        # Perform segmentation
        pred = model.predict(image, verbose=0)[0]
        pred = np.argmax(pred, axis=-1)
        pred = pred.astype(np.float32)

        # Save the results
        save_results(image[0] * 255.0, pred)

        # Get the percentages
        class_percentages = getPercentages(pred, COLORMAP, CLASSES)
        class_percentages = [(label, percentage) for label, percentage in zip(CLASSES, class_percentages)]

        # Render the template with the results
        return render_template('index.html', image_path='path/to/saved/image.jpg', class_percentages=class_percentages)

    # Render the initial template
    return render_template('index.html')

if __name__ == "__main__":
    load_model()
    app.run()
