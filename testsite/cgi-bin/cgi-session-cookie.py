# CGI script for testing a web server


import os
import sys
import time
import signal
import fileinput
from datetime import datetime


def get_visit_count():
	def get_cookie(name):
		cookies = os.environ.get("HTTP_COOKIE", "")
		for cookie in cookies.split(";"):
			cookie = cookie.strip()
			if cookie.startswith(name + "="):
				return cookie[len(name)+1:]
		return None

	filename = get_cookie("sessionId")
	# Client has cookie
	if filename is not None:
		# First time coming
		if not os.path.exists(filename):
			# Create file
			with open(filename, 'w') as f:
				f.write("1")
		# Read count from file
		count = None
		with open(filename, 'r') as f:
			count = int(f.read().strip())
		# Increment and save
		count += 1
		with open(filename, 'w') as f:
			f.write(str(count))
		return count
	else:
		return 1


def construct_response_body(request_body):
	body = ''
	body += '<html><head><style>'
	body += 'body{background-color:#262626;color:#e2e2e2;font-family:Consolas,Monaco,Courier New;}'
	body += '</style></head>'
	
	body += '<body>'
	body += '<h2>Hello from Python script!</h2>'
	
	body += '<br><b>Time:</b> ' + datetime.now().strftime("%Y-%m-%d %H:%M:%S")
	
	body += '<br><br><b>Here is a countdown from a for loop:</b> '
	for i in range(3, 0, -1):
		body += str(i) + '\n'

	body += '<br><br><b>Request body:</b> '
	body += request_body
	
	body += '<br><br><b>Env vars:</b>\n'
	for key, value in os.environ.items():
		body += f'<br>&nbsp;  {key}={value}\n'
	
	body += f'<br><br><b>argv:</b> {sys.argv}'
	body += '<br><i>(Python interpreter internally ignores real argv[0])</i>'

	body += f'<br><br>cwd:</b> {os.getcwd()}'

	body += f'<br><br><b>You visited this webpage: {get_visit_count()} times'
	body += '</body></html>'
	return body


def construct_response_headers(body):
	headers = ''
	headers += 'Content-Type: text/html\r\n'
	headers += 'Content-Length: ' + str(len(body)) + '\r\n'
	headers += 'Header-from-cgi-script: hello_world\r\n'
	return headers


# Read stdin for request body
request_body = ''
for line in fileinput.input():
	request_body += line

# Prepare response
body = construct_response_body(request_body)
headers = construct_response_headers(body)

# time.sleep(12)                         # Sleep
# r = 2 + 's'                            # Crash
# os.kill(os.getpid() , signal.SIGTERM)  # Signal exit


# Print response to stdout
#
# RFC 3875 CGI 1.1
# Response type: 1 or more header files, blank line, message body (may be null)
print(headers, end='')
print('\r\n', end='')
print(body, end='')
# print('\n<br> If Content-Length was set, this text could be ignored by clients.')