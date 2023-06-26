#API

## Usage

1. Send a POST request to the API with an image to recognize:

3. The API will return a JSON response containing the recognized name:

```
{
  "pokemon": "pikachu"
}
```

## Folder Structure

- `app.py`: The main file containing the Flask application and prediction functions.
- `pokemon_recognition_model.h5`: The file containing the pre-trained deep learning model for Pokémon recognition.
- `class_indices.json`: The dictionary mapping class names to their indices.
