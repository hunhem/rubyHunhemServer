# Be sure to restart your server when you modify this file.

#HunhemServer::Application.config.session_store :cookie_store, key: '_hunhem_server_session'

HunhemServer::Application.config.session_store :redis_store, servers: 'redis://localhost:6379/0/session'

#HunhemServer::Application.config.session_store :redis_store, servers: { host: "localhost",
#                                                                         port: 6379,
#                                                                         db: 0,
#                                                                         password: "mysecret",
#                                                                         namespace: "session"
#                                                                       },
#                                                                       expires_in: 90.minutes
