const Http = require('http');

const Server = Http.createServer((Request, Response) => {
    const Parsed = new URL(Request.url, `http://localhost`);
    if (Parsed.pathname.startsWith('/whitelist')) {
        const Key = Parsed.searchParams.get('Key');
        const Rng = Parsed.searchParams.get('Rng');
        Response.writeHead(200, { 'Content-Type': 'application/json' });
        if (Key === 'DynamicKey') {
            const NewRng = (parseFloat(Rng) * 67) - 41;
            Response.end(JSON.stringify({ Whitelisted: true, NewRng: NewRng }));
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