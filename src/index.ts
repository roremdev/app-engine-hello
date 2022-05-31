import server from './server';

server.set("PORT", process.env.PORT || 8080)

server.listen(server.get('PORT'), () => {
    console.log('⬢ Zentrity')
})