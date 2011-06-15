import re
config = {
		'name' : "Remove Newline",
		'description' : "Removes new lines",
		'aliases': ['rmhtml']
		}

def run(text):
    pattern = re.compile(
        r'<!--.*?-->',
        re.DOTALL | re.MULTILINE
    )
    return pattern.sub('', text)
