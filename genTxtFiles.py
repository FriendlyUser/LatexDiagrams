# openai script that generates descriptions and keywords for a given tex file


import os
import subprocess
import random
import time
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
    sessionToken = os.getenv("CHATGPT_TOKEN")
    sample_prompt = f"""
    You will be given a series of latex source code for diagrams followed by two prompts

        for prompt 1: describe the code above. Do not output the code itself or provide similar examples to the source code.

        for prompt 2: what are the keywords for the latex diagram in a comma separated list with no other text. Do not include the word latex or diagram or documentclass or usepackage in your response.
    
    respond with confirm if you understand.
    """
    api = ChatGPT(sessionToken)
    api.send_message(sample_prompt)
    curr_count = 0
    max_count = 10
    for f in get_files():
        # print(file)
        # get relative path to file
        rel_path = os.path.relpath(f, path)
        # read text file
        with open(f, 'r') as raw_tex_file:
            tex_source = raw_tex_file.read()

        description_txt = rel_path.replace('.tex', '_description.txt')
        # replace .tex with keywords_.txt
        keywords_txt = rel_path.replace('.tex', '_keywords.txt')

        # if both files exist skip
        if os.path.exists(description_txt) and os.path.exists(keywords_txt):
            continue
        # check if description_txt and keywords_txt exist
        if os.path.exists(description_txt) == False:
            raw_resp = api.send_message(f"{tex_source} \n \n \n describe the code above.")
            # replace .tex withnt description_.txt
            tex_description = raw_resp['message']
            # save description to file
            with open(description_txt, 'w') as description_file:
                description_file.write(tex_description)
            # randomly sleep for 3 to 6 seconds
            time.sleep(random.randint(3, 6))
        
        if os.path.exists(keywords_txt) == False:
            # generate keywords
            raw_resp = api.send_message(f"what are the keywords for the latex diagram above in a comma separated list with no other text.  Do not include the word latex or diagram in your response.")
            # get output and save to keywords_txt
            tex_keywords = raw_resp['message']
            # save keywords to file
            with open(keywords_txt, 'w') as keywords_file:
                keywords_file.write(tex_keywords)

        # increase curr_count
        curr_count += 1
        # exit after 10 files
        if curr_count >= max_count:
            break
        time.sleep(random.randint(3, 6))


if __name__ == '__main__':
    main()
