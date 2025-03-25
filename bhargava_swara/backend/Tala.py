import os
import google.generativeai as genai
import tkinter as tk
from tkinter import filedialog, scrolledtext
import threading

def analyze_music_gemini(audio_data, file_name):
    """Analyzes music and returns analysis result for Thala only."""
    try:
        genai.configure(api_key="YOUR_API_KEY")  # Replace with your actual API key
        model = genai.GenerativeModel("gemini-2.0-flash-thinking-exp-01-21")

        prompt_text = """
        Analyze the musical characteristics of the audio.
        Assume this audio is Indian classical music.
        Identify and extract the following musical element:
        - Thala

        Output the extracted details in the following format:

        -------------------
        EXTRACTED DETAILS

        THALA :- [Thala Name]
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
        safety_settings = [ {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE",}]

        response = model.generate_content(
            contents=contents,
            generation_config=generate_content_config,
            safety_settings=safety_settings
        )
        return response.text

    except Exception as e:
        return f"Error during analysis: {str(e)}"

def open_file_dialog_and_analyze():
    file_path = filedialog.askopenfilename(
        title="Select Audio File",
        filetypes=(("Audio files", "*.mp3;*.wav"), ("All files", "*.*")),
    )
    if file_path:
        try:
            with open(file_path, "rb") as audio_file:
                audio_data = audio_file.read()

            output_text_area.config(state=tk.NORMAL)
            output_text_area.delete("1.0", tk.END)
            output_text_area.insert(tk.END, "Analyzing music...\n")
            root.update_idletasks()

            threading.Thread(
                target=perform_analysis_threaded,
                args=(audio_data, os.path.basename(file_path))
            ).start()

        except Exception as e:
            output_text_area.config(state=tk.NORMAL)  # Enable text area for writing
            output_text_area.delete("1.0", tk.END)     # Clear previous content
            output_text_area.insert(tk.END, f"Error reading audio file: {e}") # Insert error message
            output_text_area.config(state=tk.DISABLED) # Disable text area again


def perform_analysis_threaded(audio_data, file_name):
    analysis_result = analyze_music_gemini(audio_data, file_name)
    display_thala_output(analysis_result) # Corrected function call

def display_thala_output(analysis_result):
    output_text_area.config(state=tk.NORMAL)
    output_text_area.delete("1.0", tk.END)

    try:
        start_index = analysis_result.find("THALA :-")
        end_index = analysis_result.find("-------------", start_index)

        if start_index != -1 and end_index != -1:
            thala_part = analysis_result[start_index:end_index].strip()

            output_text_area.insert(tk.END, "-------------------\n")
            output_text_area.insert(tk.END, "EXTRACTED DETAILS\n\n")
            output_text_area.insert(tk.END, thala_part + "\n")
            output_text_area.insert(tk.END, "-------------\n")

        else:
            output_text_area.insert(tk.END, "Could not extract Thala.\n")

    except Exception as e:
        output_text_area.insert(tk.END, f"Error displaying output: {e}\n")

    output_text_area.config(state=tk.DISABLED)


root = tk.Tk()
root.title("Thala Analysis")

button_select_file = tk.Button(
    root, text="Select Audio File", command=open_file_dialog_and_analyze
)
button_select_file.pack(pady=20)

output_text_area = scrolledtext.ScrolledText(
    root, wrap=tk.WORD, height=20, width=80, state=tk.DISABLED
)
output_text_area.pack(padx=20, pady=20)

if __name__ == "__main__":
    root.mainloop()