// Storage servers.
local storageAddresses = [
  'storage-0.storage.buildbarn:8981',
  'storage-1.storage.buildbarn:8981',
];

local grpc(address) = {
  grpc: {
    client: { address: address },
    enableCompression: true,
  },
};

// Distribute a backend across the storage servers in a sharded manner.
local sharded(backendForAddress) = {
  sharding: {
    shards: {
      [std.toString(i)]: {
        backend: backendForAddress(storageAddresses[i]),
        weight: 1,
      },
      for i in std.range(0, std.length(storageAddresses) - 1)
    },
  },
};

// Cheap cache that saves a GetCapabilities call for every CDC interaction.
local cdcParameterCache = {
  cacheSize: 1000,
  cacheDuration: '60s',
  cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
};

{
  chunkStorage: sharded(grpc),
  chunkMappingStorage: {
    chunkMappingValidating: {
      backend: sharded(grpc),
    },
  },
  cdcParameterCache: cdcParameterCache,
  actionCache: {
    completenessChecking: {
      backend: sharded(grpc),
      maximumTotalTreeSizeBytes: 64 * 1024 * 1024,
    },
  },
  fileSystemAccessCache: sharded(grpc),
  initialSizeClassCache: sharded(grpc),
}
