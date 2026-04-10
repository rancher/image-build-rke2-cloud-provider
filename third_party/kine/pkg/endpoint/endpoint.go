package endpoint

// This is a stub replacement for github.com/k3s-io/kine/pkg/endpoint to avoid
// pulling in all of the kine deps. No kine code is actually used in this project,
// but it is pulled in as an indirect dep by github.com/k3s-io/k3s/pkg/daemons/config

type ETCDConfig struct{}

type Config struct{}
