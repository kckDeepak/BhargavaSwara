import os
import google.generativeai as genai
import tkinter as tk
from tkinter import filedialog, scrolledtext
import threading
import sounddevice as sd
import numpy as np
import io
import wave
from scipy.io.wavfile import write as wav_write

# Global variables for real-time audio
recording = False
stream = None
samplerate = 44100  # Standard sample rate
channels = 2        # Mono audio
audio_buffer = []   # Buffer to accumulate audio data
buffer_duration = 10 # Accumulate audio for 5 seconds before analysis

def analyze_music_gemini(audio_data_wav):
    """
    Analyzes music using the Gemini model from Google Generative AI with WAV audio data.
    ... (rest of the analyze_music_gemini function remains the same) ...
    """
    try:
        # Configure the API client with your API key
        genai.configure(api_key="AIzaSyBtzfntQ8hfcpR6JG7d0xXxQjN1zSdcILw")  # Replace with your actual API key

        # Instantiate the model (adjust model name if needed based on availability)
        model = genai.GenerativeModel("gemini-2.0-flash-thinking-exp-01-21")  # Updated to a known model

        # Define the prompt for analyzing Indian classical music
        prompt_text = """
        Analyze the audio provided.

Instructions:

1.  **Initial Identification:** Begin by attempting to classify the audio as Indian classical music (Hindustani or Carnatic tradition).

2.  **If Identified as Indian Classical:**
    *   Identify and extract the following musical elements to the best of your ability:
        *   MUSIC TRADITION (Hindustani or Carnatic)
        *   RAGA (Identify the Raga name, focusing on common and fundamental Ragas. If the Raga is a variation or less common, clearly state that it's a variation and name the closest recognized Raga.)
        *   THALA (Identify the Thala name, focusing on core and well-known Thalas. If the Thala is a variation, mention the closest recognized Thala.)
        *   TEMPO (Describe the Tempo using appropriate terms like Vilambit, Madhya, Drut, or slow, medium, fast).
        *   ORNAMENTS (Determine if ornaments are present (YES/NO). If YES, list prominent ornament names like Gamaka, Meend, etc.)

    *   **Deviation Analysis and Corrections:**
        *   If any element (Raga, Thala) deviates from a standard or recognized form, provide specific suggestions to correct the deviation and bring it closer to a standard performance. For example, "The Raga resembles Yaman but has [specific deviation]. To correct, [suggested change]." Be specific.

    *   **Output Format:** Present the extracted details in the format below:

        -------------------
        EXTRACTED DETAILS

        MUSIC TRADITION :- [Tradition, or "Not Indian Classical Music" if applicable]
        instruments:- [List instruments heard]
        mood:- [Describe the overall mood]
        RAGA :- [Raga Name, or "Unidentifiable" if unable to determine]
        THALA :- [Thala Name, or "Unidentifiable" if unable to determine]
        TEMPO :- [Tempo description]
        ORNAMENTS :- [YES/NO]
        [If YES, list ornament names: ...]
        Correction:- [Specific correction suggestions, or "None" if no deviations are found]
        Other information:-[if any]
        -------------

3.  **If NOT Identified as Indian Classical Music:**
    *   Describe the sonic characteristics of the audio as accurately as possible.
        *   What type of music does it sound like (e.g., Western classical, pop, jazz, folk, ambient, etc.)?
        *   What instruments are present?
        *   What is the overall mood or feeling conveyed by the music?
    *   In the "EXTRACTED DETAILS" section:
        *   Set MUSIC TRADITION to "Not Indian Classical Music"
        *   Set RAGA and THALA to "Unidentifiable".
        *   Populate the "Other information" field with your description of the audio's sonic characteristics and genre, etc..
4. try to avoid default answers  be honest,

Remember to analyze carefully and provide the most accurate and helpful information possible. Listen to the audio multiple times before making a final determination.
        """

        # MIME type for WAV audio
        mime_type = "audio/wav"

        # Build contents as a list of dictionaries with parts
        contents = [{
            "parts": [
                {"text": prompt_text},
                {"inline_data": {"data": audio_data_wav, "mime_type": mime_type}}
            ]
        }]

        # Define generation configuration as a dictionary
        generate_content_config = {
            "temperature": 0.0,
            "top_p": 0.1,
            "top_k": 1,
            "max_output_tokens": 2048,
        }

        # Define safety settings
        safety_settings = [
            {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_NONE",
            }
        ]

        # Generate content
        response = model.generate_content(
            contents=contents,
            generation_config=generate_content_config,
            safety_settings=safety_settings
        )
        return response.text

    except Exception as e:
        return f"Error during analysis: {str(e)}"


def audio_callback(indata, frames, time, status):
    """This is called (from a separate thread) for each audio block."""
    global audio_buffer
    if status:
        print(status)
    if recording:
        audio_buffer.append(indata.copy()) # Append the current audio chunk to the buffer

        # Calculate buffered duration in seconds
        buffered_duration = len(audio_buffer) * frames / samplerate

        if buffered_duration >= buffer_duration: # If buffer duration is reached
            numpy_audio_data = np.concatenate(audio_buffer, axis=0) # Concatenate all chunks in buffer
            wav_data = convert_numpy_to_wav_bytes(numpy_audio_data, samplerate)
            threading.Thread(target=perform_realtime_analysis_threaded, args=(wav_data,)).start()
            audio_buffer = [] # Clear the buffer after sending for analysis


def convert_numpy_to_wav_bytes(numpy_audio, rate):
    """Converts NumPy array audio to WAV bytes."""
    byte_io = io.BytesIO()
    wav_write(byte_io, rate, numpy_audio)
    wav_bytes = byte_io.getvalue()
    return wav_bytes


def start_realtime_analysis():
    """Starts real-time audio analysis from the microphone."""
    global recording, stream, audio_buffer
    if not recording:
        output_text_area.config(state=tk.NORMAL)
        output_text_area.delete("1.0", tk.END)
        output_text_area.insert(tk.END, f"Starting real-time analysis, buffering {buffer_duration} seconds of audio...\n")
        output_text_area.config(state=tk.DISABLED)
        recording = True
        audio_buffer = [] # Initialize empty buffer when starting
        try:
            stream = sd.InputStream(
                samplerate=samplerate,
                channels=channels,
                callback=audio_callback
            )
            stream.start()
            button_start_realtime.config(state=tk.DISABLED)
            button_stop_realtime.config(state=tk.NORMAL)

        except Exception as e:
            display_realtime_analysis_output(f"Error starting audio stream: {e}")
            recording = False
            button_start_realtime.config(state=tk.NORMAL)
            button_stop_realtime.config(state=tk.DISABLED)


def stop_realtime_analysis():
    """Stops real-time audio analysis."""
    global recording, stream
    if recording:
        output_text_area.config(state=tk.NORMAL)
        output_text_area.insert(tk.END, "Stopping real-time analysis...\n")
        output_text_area.config(state=tk.DISABLED)
        recording = False
        if stream:
            stream.stop()
            stream.close()
        button_start_realtime.config(state=tk.NORMAL)
        button_stop_realtime.config(state=tk.DISABLED)


def perform_realtime_analysis_threaded(audio_data_wav):
    """Performs real-time analysis in a thread and updates the GUI."""
    analysis_result = analyze_music_gemini(audio_data_wav)
    display_realtime_analysis_output(analysis_result)

def display_realtime_analysis_output(analysis_result):
    """Displays the real-time analysis output in the GUI."""
    output_text_area.config(state=tk.NORMAL)
    output_text_area.delete("1.0", tk.END) # Clear previous output for real-time update
    output_text_area.insert(tk.END, "Real-time Analysis Output:\n")
    output_text_area.insert(tk.END, analysis_result)
    output_text_area.config(state=tk.DISABLED)


# GUI Setup
root = tk.Tk()
root.title("Real-time Music Analysis Tool")

button_start_realtime = tk.Button(
    root, text="Start Real-time Analysis", command=start_realtime_analysis
)
button_start_realtime.pack(pady=20)

button_stop_realtime = tk.Button(
    root, text="Stop Real-time Analysis", command=stop_realtime_analysis, state=tk.DISABLED
)
button_stop_realtime.pack(pady=10)


output_text_area = scrolledtext.ScrolledText(
    root, wrap=tk.WORD, height=20, width=80, state=tk.DISABLED
)
output_text_area.pack(padx=20, pady=20)

if __name__ == "__main__":
    root.mainloop()