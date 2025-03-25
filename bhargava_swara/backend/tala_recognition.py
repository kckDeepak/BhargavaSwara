import os
import google.generativeai as genai
from flask import Flask, request

app = Flask(__name__)

# Configure Gemini API
genai.configure(api_key="YOUR_API_KEY")  # Replace with your actual API key

def analyze_music_gemini(audio_data, file_name):
    """Analyzes music and returns analysis result for Tala only."""
    try:
        model = genai.GenerativeModel("gemini-2.0-flash-thinking-exp-01-21")

        prompt_text = """
        Analyze the musical characteristics of the audio.
        Assume this audio is Indian classical music.
        Identify and extract the following musical element:
        - Tala

        Output the extracted details in the following format:

        -------------------
        EXTRACTED DETAILS

        TALA :- [Tala Name]
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

def extract_tala(analysis_result):
    """Extracts the Tala name from the Gemini response."""
    try:
        start_index = analysis_result.find("TALA :-")
        end_index = analysis_result.find("-------------", start_index)
        if start_index != -1 and end_index != -1:
            tala_part = analysis_result[start_index + 8:end_index].strip()  # Skip "TALA :- "
            return tala_part
        return "Unknown Tala"
    except Exception:
        return "Error extracting Tala"

@app.route('/analyze-tala', methods=['POST'])
def analyze_tala():
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
    detected_tala = extract_tala(analysis_result)

    # Clean up the uploaded file
    os.remove(file_path)

    return detected_tala

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)  # Port 5001 to avoid conflict