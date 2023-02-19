# openai script that generates descriptions and keywords for a given tex file


import os
import subprocess
from pyChatGPT import ChatGPT


path = os.path.dirname(os.path.realpath(__file__))

def get_files():
    # r=root, d=directories, f = files
    for r, d, f in os.walk(path):
        for file in f:
            if '.tex' in file:
                yield os.path.join(r, file)


def main():
    # seed prompt
    sessionToken = '1234567890'
    sample_prompt = f"""
    You will be given a series of latex source code for diagrams followed by two prompts

        for prompt 1: describe latex diagram

        for prompt 2: what are the keywords for the latex diagram in a comma separated list with no other text.
    
    respond with confirm if you understand.
    """
    api = ChatGPT()
    for f in get_files():
        # print(file)
        # get relative path to file
        rel_path = os.path.relpath(f, path)
        print(rel_path)
        # replace .tex with description_.txt
        description_txt = rel_path.replace('.tex', '_description.txt')
        # replace .tex with keywords_.txt
        keywords_txt = rel_path.replace('.tex', '_keywords.txt')
        # remove filename from path
        # rel_path = os.path.dirname(rel_path)
        # print(rel_path)

if __name__ == '__main__':
    main()
