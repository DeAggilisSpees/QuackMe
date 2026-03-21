const Http = require('http');

const Server = Http.createServer((Request, Response) => {
    const Parsed = new URL(Request.url, `http://localhost`);
    if (Parsed.pathname.startsWith('/whitelist')) {
        const Key = Parsed.searchParams.get('Key');
        Response.writeHead(200, { 'Content-Type': 'application/json' });
        if (Key === 'StaticKey') {
            Response.end(JSON.stringify({ Whitelisted: true }));
        } else {
            Response.end(JSON.stringify({ Whitelisted: false }));
        }
    } else {
        Response.writeHead(404);
        Response.end('Not found');
    }
});

const Port = 3000;
Server.listen(Port, () => {
    console.log(`Server running on http://localhost:${Port}`);
});