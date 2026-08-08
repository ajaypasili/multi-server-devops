const http = require("http");

const PORT = 3000;

const server = http.createServer((req, res) => {
    res.writeHead(200, {
        "Content-Type": "text/html"
    });

    res.end(`
<!DOCTYPE html>
<html>
<head>
    <title>Multi-Server DevOps Assignment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        h1 {
            font-size: 40px;
        }
        p {
            font-size: 20px;
        }
    </style>
</head>

<body>

    <h1>Multi-Server DevOps Deployment</h1>

    <p>Application is running successfully.</p>

    <p>Primary Server: AWS Europe</p>

    <p>Backup Server: AWS India</p>

</body>
</html>
    `);
});

server.listen(PORT, "0.0.0.0", () => {
    console.log(`Application running on port ${PORT}`);
});
