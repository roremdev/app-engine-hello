import server from './server';

server.set("PORT", process.env.PORT || 80)

server.listen(server.get('PORT'), () => {
    console.log('⬢ Zentrity')
    console.log('⬢ Server on %s PORT', server.get('PORT'))
})