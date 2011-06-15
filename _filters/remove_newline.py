config = {
	'name' : "Remove Newline",
	'description' : "Removes new lines",
	'aliases': ['rmnl']
	}

def run(text):
	return text.replace("\n",'').strip()
