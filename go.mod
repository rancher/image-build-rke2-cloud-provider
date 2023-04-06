module github.com/rancher/image-build-rke2-cloud-provider

go 1.19

replace (
	github.com/Mirantis/cri-dockerd => github.com/k3s-io/cri-dockerd v0.3.2-0.20230123224936-bcd78c2d21d8
	github.com/containerd/containerd => github.com/k3s-io/containerd v1.5.16-k3s1
	github.com/golang/protobuf => github.com/golang/protobuf v1.5.2
	go.etcd.io/etcd => github.com/k3s-io/etcd v0.5.0-alpha.5.0.20201208200253-50621aee4aea
	google.golang.org/grpc => google.golang.org/grpc v1.40.0
	k8s.io/api => github.com/k3s-io/kubernetes/staging/src/k8s.io/api v1.26.3-k3s1
	k8s.io/apiextensions-apiserver => github.com/k3s-io/kubernetes/staging/src/k8s.io/apiextensions-apiserver v1.26.3-k3s1
	k8s.io/apimachinery => github.com/k3s-io/kubernetes/staging/src/k8s.io/apimachinery v1.26.3-k3s1
	k8s.io/apiserver => github.com/k3s-io/kubernetes/staging/src/k8s.io/apiserver v1.26.3-k3s1
	k8s.io/cli-runtime => github.com/k3s-io/kubernetes/staging/src/k8s.io/cli-runtime v1.26.3-k3s1
	k8s.io/client-go => github.com/k3s-io/kubernetes/staging/src/k8s.io/client-go v1.26.3-k3s1
	k8s.io/cloud-provider => github.com/k3s-io/kubernetes/staging/src/k8s.io/cloud-provider v1.26.3-k3s1
	k8s.io/cluster-bootstrap => github.com/k3s-io/kubernetes/staging/src/k8s.io/cluster-bootstrap v1.26.3-k3s1
	k8s.io/code-generator => github.com/k3s-io/kubernetes/staging/src/k8s.io/code-generator v1.26.3-k3s1
	k8s.io/component-base => github.com/k3s-io/kubernetes/staging/src/k8s.io/component-base v1.26.3-k3s1
	k8s.io/component-helpers => github.com/k3s-io/kubernetes/staging/src/k8s.io/component-helpers v1.26.3-k3s1
	k8s.io/controller-manager => github.com/k3s-io/kubernetes/staging/src/k8s.io/controller-manager v1.26.3-k3s1
	k8s.io/cri-api => github.com/k3s-io/kubernetes/staging/src/k8s.io/cri-api v1.26.3-k3s1
	k8s.io/csi-translation-lib => github.com/k3s-io/kubernetes/staging/src/k8s.io/csi-translation-lib v1.26.3-k3s1
	k8s.io/dynamic-resource-allocation => github.com/k3s-io/kubernetes/staging/src/k8s.io/dynamic-resource-allocation v1.26.3-k3s1
	k8s.io/klog => github.com/k3s-io/klog v1.0.0-k3s2 // k3s-release-1.x
	k8s.io/klog/v2 => github.com/k3s-io/klog/v2 v2.80.1-k3s1 // k3s-main
	k8s.io/kms => github.com/k3s-io/kubernetes/staging/src/k8s.io/kms v1.26.3-k3s1
	k8s.io/kube-aggregator => github.com/k3s-io/kubernetes/staging/src/k8s.io/kube-aggregator v1.26.3-k3s1
	k8s.io/kube-controller-manager => github.com/k3s-io/kubernetes/staging/src/k8s.io/kube-controller-manager v1.26.3-k3s1
	k8s.io/kube-proxy => github.com/k3s-io/kubernetes/staging/src/k8s.io/kube-proxy v1.26.3-k3s1
	k8s.io/kube-scheduler => github.com/k3s-io/kubernetes/staging/src/k8s.io/kube-scheduler v1.26.3-k3s1
	k8s.io/kubectl => github.com/k3s-io/kubernetes/staging/src/k8s.io/kubectl v1.26.3-k3s1
	k8s.io/kubelet => github.com/k3s-io/kubernetes/staging/src/k8s.io/kubelet v1.26.3-k3s1
	k8s.io/kubernetes => github.com/k3s-io/kubernetes v1.26.3-k3s1
	k8s.io/legacy-cloud-providers => github.com/k3s-io/kubernetes/staging/src/k8s.io/legacy-cloud-providers v1.26.3-k3s1
	k8s.io/metrics => github.com/k3s-io/kubernetes/staging/src/k8s.io/metrics v1.26.3-k3s1
	k8s.io/mount-utils => github.com/k3s-io/kubernetes/staging/src/k8s.io/mount-utils v1.26.3-k3s1
	k8s.io/node-api => github.com/k3s-io/kubernetes/staging/src/k8s.io/node-api v1.26.3-k3s1
	k8s.io/pod-security-admission => github.com/k3s-io/kubernetes/staging/src/k8s.io/pod-security-admission v1.26.3-k3s1
	k8s.io/sample-apiserver => github.com/k3s-io/kubernetes/staging/src/k8s.io/sample-apiserver v1.26.3-k3s1
	k8s.io/sample-cli-plugin => github.com/k3s-io/kubernetes/staging/src/k8s.io/sample-cli-plugin v1.26.3-k3s1
	k8s.io/sample-controller => github.com/k3s-io/kubernetes/staging/src/k8s.io/sample-controller v1.26.3-k3s1
)

require (
	github.com/k3s-io/k3s v1.26.4-0.20230406214407-027cc187ce9f // master
	github.com/spf13/pflag v1.0.5
	k8s.io/apimachinery v0.26.3
	k8s.io/cloud-provider v0.26.3
	k8s.io/component-base v0.26.3
	k8s.io/klog/v2 v2.80.1
)

require (
	github.com/Azure/go-ansiterm v0.0.0-20210617225240-d185dfc1b5a1 // indirect
	github.com/NYTimes/gziphandler v1.1.1 // indirect
	github.com/antlr/antlr4/runtime/Go/antlr v1.4.10 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/blang/semver/v4 v4.0.0 // indirect
	github.com/cenkalti/backoff/v4 v4.2.0 // indirect
	github.com/cespare/xxhash/v2 v2.2.0 // indirect
	github.com/coreos/go-semver v0.3.0 // indirect
	github.com/coreos/go-systemd/v22 v22.5.0 // indirect
	github.com/cpuguy83/go-md2man/v2 v2.0.2 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/emicklei/go-restful/v3 v3.9.0 // indirect
	github.com/evanphx/json-patch v4.12.0+incompatible // indirect
	github.com/felixge/httpsnoop v1.0.3 // indirect
	github.com/fsnotify/fsnotify v1.6.0 // indirect
	github.com/go-logr/logr v1.2.3 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-openapi/jsonpointer v0.19.5 // indirect
	github.com/go-openapi/jsonreference v0.20.0 // indirect
	github.com/go-openapi/swag v0.19.14 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/google/cel-go v0.12.6 // indirect
	github.com/google/gnostic v0.5.7-v3refs // indirect
	github.com/google/go-cmp v0.5.9 // indirect
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/google/uuid v1.3.0 // indirect
	github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0 // indirect
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.7.0 // indirect
	github.com/imdario/mergo v0.3.12 // indirect
	github.com/inconshreveable/mousetrap v1.1.0 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/mailru/easyjson v0.7.6 // indirect
	github.com/matttproud/golang_protobuf_extensions v1.0.4 // indirect
	github.com/moby/term v0.0.0-20220808134915-39b0c02b01ae // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/prometheus/client_golang v1.14.0 // indirect
	github.com/prometheus/client_model v0.3.0 // indirect
	github.com/prometheus/common v0.39.0 // indirect
	github.com/prometheus/procfs v0.9.0 // indirect
	github.com/rancher/dynamiclistener v0.3.5 // indirect
	github.com/rancher/lasso v0.0.0-20221227210133-6ea88ca2fbcc // indirect
	github.com/rancher/wrangler v1.1.1 // indirect
	github.com/russross/blackfriday/v2 v2.1.0 // indirect
	github.com/sirupsen/logrus v1.9.0 // indirect
	github.com/spf13/cobra v1.6.1 // indirect
	github.com/stoewer/go-strcase v1.2.0 // indirect
	github.com/urfave/cli v1.22.9 // indirect
	go.etcd.io/etcd/api/v3 v3.5.7 // indirect
	go.etcd.io/etcd/client/pkg/v3 v3.5.7 // indirect
	go.etcd.io/etcd/client/v3 v3.5.7 // indirect
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.35.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.35.0 // indirect
	go.opentelemetry.io/otel v1.11.2 // indirect
	go.opentelemetry.io/otel/exporters/otlp/internal/retry v1.11.2 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace v1.11.2 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc v1.11.2 // indirect
	go.opentelemetry.io/otel/metric v0.31.0 // indirect
	go.opentelemetry.io/otel/sdk v1.11.2 // indirect
	go.opentelemetry.io/otel/trace v1.11.2 // indirect
	go.opentelemetry.io/proto/otlp v0.19.0 // indirect
	go.uber.org/atomic v1.10.0 // indirect
	go.uber.org/multierr v1.9.0 // indirect
	go.uber.org/zap v1.24.0 // indirect
	golang.org/x/crypto v0.5.0 // indirect
	golang.org/x/net v0.8.0 // indirect
	golang.org/x/oauth2 v0.3.0 // indirect
	golang.org/x/sync v0.1.0 // indirect
	golang.org/x/sys v0.6.0 // indirect
	golang.org/x/term v0.6.0 // indirect
	golang.org/x/text v0.8.0 // indirect
	golang.org/x/time v0.3.0 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/genproto v0.0.0-20230106154932-a12b697841d9 // indirect
	google.golang.org/grpc v1.51.0 // indirect
	google.golang.org/protobuf v1.28.1 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	gopkg.in/natefinch/lumberjack.v2 v2.0.0 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	k8s.io/api v0.26.3 // indirect
	k8s.io/apiserver v0.26.3 // indirect
	k8s.io/client-go v11.0.1-0.20190409021438-1a26190bd76a+incompatible // indirect
	k8s.io/component-helpers v0.26.3 // indirect
	k8s.io/controller-manager v0.26.3 // indirect
	k8s.io/kms v0.0.0 // indirect
	k8s.io/kube-openapi v0.0.0-20221012153701-172d655c2280 // indirect
	k8s.io/utils v0.0.0-20221107191617-1a15be271d1d // indirect
	sigs.k8s.io/apiserver-network-proxy/konnectivity-client v0.0.36 // indirect
	sigs.k8s.io/json v0.0.0-20220713155537-f223a00ba0e2 // indirect
	sigs.k8s.io/structured-merge-diff/v4 v4.2.3 // indirect
	sigs.k8s.io/yaml v1.3.0 // indirect
)

require (
	github.com/golang/glog v1.1.0 // indirect
	github.com/google/pprof v0.0.0-20210720184732-4bb14d4b1be1 // indirect
	github.com/onsi/ginkgo/v2 v2.9.1 // indirect
	github.com/onsi/gomega v1.27.4 // indirect
)
