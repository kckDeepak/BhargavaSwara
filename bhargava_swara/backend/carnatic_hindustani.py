import os
import google.generativeai as genai
from flask import Flask, request

app = Flask(__name__)

# Configure Gemini API
genai.configure(api_key="YOUR_API_KEY")  # Replace with your actual API key

def analyze_music_gemini(audio_data, file_name):
    """Analyzes music and returns analysis result for Music Tradition only."""
    try:
        model = genai.GenerativeModel("gemini-2.0-flash-thinking-exp-01-21")

        prompt_text = """
        Analyze the musical characteristics of the audio.
        Assume this audio is Indian classical music.
        Identify and extract the following musical element:
        - Music Tradition (Hindustani or Carnatic)

        Output the extracted details in the following format:

        -------------------
        EXTRACTED DETAILS

        MUSIC TRADITION :- [Tradition]
        -------------
        """

        mime_type = "audio/mpeg" if file_name.lower().endswith(".mp3") else "audio/wav"
        contents = [{
            "parts": [
                {"text": prompt_text},
                {"inline_data": {"data": audio_data, "mime_type": mime_type}}
            ]
        }]

        generate_content_config = {
            "temperature": 0.0,
            "top_p": 0.9,
            "top_k": 32,
            "max_output_tokens": 2048,
        }
        safety_settings = [{"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"}]

        response = model.generate_content(
            contents=contents,
            generation_config=generate_content_config,
            safety_settings=safety_settings
        )
        return response.text

    except Exception as e:
        return f"Error during analysis: {str(e)}"

def extract_tradition(analysis_result):
    """Extracts the music tradition from the Gemini response."""
    try:
        start_index = analysis_result.find("MUSIC TRADITION :-")
        end_index = analysis_result.find("-------------", start_index)
        if start_index != -1 and end_index != -1:
            tradition_part = analysis_result[start_index + 18:end_index].strip()  # Skip "MUSIC TRADITION :- "
            return tradition_part
        return "Unknown Tradition"
    except Exception:
        return "Error extracting Tradition"

@app.route('/analyze-style', methods=['POST'])
def analyze_style():
    if 'audio' not in request.files:
        return "No audio file provided", 400

    audio_file = request.files['audio']
    file_path = os.path.join("uploads", audio_file.filename)
    os.makedirs("uploads", exist_ok=True)
    audio_file.save(file_path)

    # Read the audio file as binary data
    with open(file_path, "rb") as f:
        audio_data = f.read()

    # Analyze the audio using Gemini
    analysis_result = analyze_music_gemini(audio_data, audio_file.filename)
    detected_tradition = extract_tradition(analysis_result)

    # Clean up the uploaded file
    os.remove(file_path)

    return detected_tradition

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5003, debug=True)  # Port 5003 to avoid conflicts