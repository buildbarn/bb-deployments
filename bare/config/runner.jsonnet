{
  buildDirectoryPath: 'build',
  grpcServers: [{
    listenPaths: ['runner'],
    authenticationPolicy: { allow: {} },
  }],
}
