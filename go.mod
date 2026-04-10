module github.com/rancher/image-build-rke2-cloud-provider

go 1.25.9

replace (
	github.com/Mirantis/cri-dockerd => github.com/k3s-io/cri-dockerd v0.3.19-k3s2
	github.com/emicklei/go-restful/v3 => github.com/emicklei/go-restful/v3 v3.11.0
	github.com/golang/protobuf => github.com/golang/protobuf v1.5.4
	github.com/google/gnostic-models => github.com/google/gnostic-models v0.6.9
	github.com/googleapis/gax-go/v2 => github.com/googleapis/gax-go/v2 v2.12.0
	github.com/k3s-io/kine => ./third_party/kine
	github.com/prometheus/client_golang => github.com/prometheus/client_golang v1.22.0
	github.com/prometheus/common => github.com/prometheus/common v0.62.0
	go.opentelemetry.io/contrib/instrumentation/github.com/emicklei/go-restful/otelrestful => go.opentelemetry.io/contrib/instrumentation/github.com/emicklei/go-restful/otelrestful v0.44.0
	google.golang.org/genproto => google.golang.org/genproto v0.0.0-20230525234035-dd9d682886f9
	google.golang.org/grpc => google.golang.org/grpc v1.72.1
	k8s.io/api => github.com/k3s-io/kubernetes/staging/src/k8s.io/api v1.33.9-k3s1
	k8s.io/apiextensions-apiserver => github.com/k3s-io/kubernetes/staging/src/k8s.io/apiextensions-apiserver v1.33.9-k3s1
	k8s.io/apimachinery => github.com/k3s-io/kubernetes/staging/src/k8s.io/apimachinery v1.33.9-k3s1
	k8s.io/apiserver => github.com/k3s-io/kubernetes/staging/src/k8s.io/apiserver v1.33.9-k3s1
	k8s.io/cli-runtime => github.com/k3s-io/kubernetes/staging/src/k8s.io/cli-runtime v1.33.9-k3s1
	k8s.io/client-go => github.com/k3s-io/kubernetes/staging/src/k8s.io/client-go v1.33.9-k3s1
	k8s.io/cloud-provider => github.com/k3s-io/kubernetes/staging/src/k8s.io/cloud-provider v1.33.9-k3s1
	k8s.io/cluster-bootstrap => github.com/k3s-io/kubernetes/staging/src/k8s.io/cluster-bootstrap v1.33.9-k3s1
	k8s.io/code-generator => github.com/k3s-io/kubernetes/staging/src/k8s.io/code-generator v1.33.9-k3s1
	k8s.io/component-base => github.com/k3s-io/kubernetes/staging/src/k8s.io/component-base v1.33.9-k3s1
	k8s.io/component-helpers => github.com/k3s-io/kubernetes/staging/src/k8s.io/component-helpers v1.33.9-k3s1
	k8s.io/controller-manager => github.com/k3s-io/kubernetes/staging/src/k8s.io/controller-manager v1.33.9-k3s1
	k8s.io/cri-api => github.com/k3s-io/kubernetes/staging/src/k8s.io/cri-api v1.33.9-k3s1
	k8s.io/cri-client => github.com/k3s-io/kubernetes/staging/src/k8s.io/cri-client v1.33.9-k3s1
	k8s.io/csi-translation-lib => github.com/k3s-io/kubernetes/staging/src/k8s.io/csi-translation-lib v1.33.9-k3s1
	k8s.io/dynamic-resource-allocation => github.com/k3s-io/kubernetes/staging/src/k8s.io/dynamic-resource-allocation v1.33.9-k3s1
	k8s.io/endpointslice => github.com/k3s-io/kubernetes/staging/src/k8s.io/endpointslice v1.33.9-k3s1
	k8s.io/externaljwt => github.com/k3s-io/kubernetes/staging/src/k8s.io/externaljwt v1.33.9-k3s1
	k8s.io/klog => github.com/k3s-io/klog v1.0.0-k3s2 // k3s-release-1.x
	k8s.io/klog/v2 => github.com/k3s-io/klog/v2 v2.140.0-k3s1 // k3s-main
	k8s.io/kms => github.com/k3s-io/kubernetes/staging/src/k8s.io/kms v1.33.9-k3s1
	k8s.io/kube-aggregator => github.com/k3s-io/kubernetes/staging/src/k8s.io/kube-aggregator v1.33.9-k3s1
	k8s.io/kube-controller-manager => github.com/k3s-io/kubernetes/staging/src/k8s.io/kube-controller-manager v1.33.9-k3s1
	k8s.io/kube-openapi => k8s.io/kube-openapi v0.0.0-20241105132330-32ad38e42d3f
	k8s.io/kube-proxy => github.com/k3s-io/kubernetes/staging/src/k8s.io/kube-proxy v1.33.9-k3s1
	k8s.io/kube-scheduler => github.com/k3s-io/kubernetes/staging/src/k8s.io/kube-scheduler v1.33.9-k3s1
	k8s.io/kubectl => github.com/k3s-io/kubernetes/staging/src/k8s.io/kubectl v1.33.9-k3s1
	k8s.io/kubelet => github.com/k3s-io/kubernetes/staging/src/k8s.io/kubelet v1.33.9-k3s1
	k8s.io/kubernetes => github.com/k3s-io/kubernetes v1.33.9-k3s1
	k8s.io/metrics => github.com/k3s-io/kubernetes/staging/src/k8s.io/metrics v1.33.9-k3s1
	k8s.io/mount-utils => github.com/k3s-io/kubernetes/staging/src/k8s.io/mount-utils v1.33.9-k3s1
	k8s.io/node-api => github.com/k3s-io/kubernetes/staging/src/k8s.io/node-api v1.33.9-k3s1
	k8s.io/pod-security-admission => github.com/k3s-io/kubernetes/staging/src/k8s.io/pod-security-admission v1.33.9-k3s1
	k8s.io/sample-apiserver => github.com/k3s-io/kubernetes/staging/src/k8s.io/sample-apiserver v1.33.9-k3s1
	k8s.io/sample-cli-plugin => github.com/k3s-io/kubernetes/staging/src/k8s.io/sample-cli-plugin v1.33.9-k3s1
	k8s.io/sample-controller => github.com/k3s-io/kubernetes/staging/src/k8s.io/sample-controller v1.33.9-k3s1
	sigs.k8s.io/cri-tools => github.com/k3s-io/cri-tools v1.33.0-k3s2
)

require (
	github.com/k3s-io/k3s v1.33.10-0.20260316230806-13a8403081db // release-1.33
	github.com/spf13/pflag v1.0.10
	k8s.io/apimachinery v0.34.5
	k8s.io/cloud-provider v0.34.5
	k8s.io/component-base v0.34.5
	k8s.io/klog/v2 v2.130.1
)

require (
	cel.dev/expr v0.24.0 // indirect
	github.com/Azure/go-ansiterm v0.0.0-20250102033503-faa5f7b0171c // indirect
	github.com/NYTimes/gziphandler v1.1.1 // indirect
	github.com/antlr4-go/antlr/v4 v4.13.0 // indirect
	github.com/asaskevich/govalidator v0.0.0-20230301143203-a9d515a09cc2 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/blang/semver/v4 v4.0.0 // indirect
	github.com/cenkalti/backoff/v5 v5.0.3 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/containerd/stargz-snapshotter/estargz v0.18.1 // indirect
	github.com/coreos/go-semver v0.3.1 // indirect
	github.com/coreos/go-systemd/v22 v22.7.0 // indirect
	github.com/cpuguy83/go-md2man/v2 v2.0.7 // indirect
	github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc // indirect
	github.com/docker/cli v29.2.0+incompatible // indirect
	github.com/docker/distribution v2.8.3+incompatible // indirect
	github.com/docker/docker-credential-helpers v0.7.0 // indirect
	github.com/emicklei/go-restful/v3 v3.13.0 // indirect
	github.com/erikdubbelboer/gspt v0.0.0-20190125194910-e68493906b83 // indirect
	github.com/evanphx/json-patch v5.9.11+incompatible // indirect
	github.com/felixge/httpsnoop v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.9.0 // indirect
	github.com/fxamacker/cbor/v2 v2.9.0 // indirect
	github.com/go-logr/logr v1.4.3 // indirect
	github.com/go-logr/stdr v1.2.3-0.20220714215716-96bad1d688c5 // indirect
	github.com/go-openapi/jsonpointer v0.22.0 // indirect
	github.com/go-openapi/jsonreference v0.21.1 // indirect
	github.com/go-openapi/swag v0.24.1 // indirect
	github.com/go-openapi/swag/cmdutils v0.24.0 // indirect
	github.com/go-openapi/swag/conv v0.24.0 // indirect
	github.com/go-openapi/swag/fileutils v0.24.0 // indirect
	github.com/go-openapi/swag/jsonname v0.24.0 // indirect
	github.com/go-openapi/swag/jsonutils v0.24.0 // indirect
	github.com/go-openapi/swag/loading v0.24.0 // indirect
	github.com/go-openapi/swag/mangling v0.24.0 // indirect
	github.com/go-openapi/swag/netutils v0.24.0 // indirect
	github.com/go-openapi/swag/stringutils v0.24.0 // indirect
	github.com/go-openapi/swag/typeutils v0.24.0 // indirect
	github.com/go-openapi/swag/yamlutils v0.24.0 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang-jwt/jwt/v5 v5.3.1 // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/google/btree v1.1.3 // indirect
	github.com/google/cel-go v0.26.0 // indirect
	github.com/google/gnostic-models v0.7.0 // indirect
	github.com/google/go-cmp v0.7.0 // indirect
	github.com/google/go-containerregistry v0.20.2 // indirect
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0 // indirect
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.27.2 // indirect
	github.com/inconshreveable/mousetrap v1.1.0 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/k3s-io/api v0.1.4 // indirect
	github.com/k3s-io/kine v0.14.14 // indirect
	github.com/klauspost/compress v1.18.4 // indirect
	github.com/kylelemons/godebug v1.1.0 // indirect
	github.com/mailru/easyjson v0.9.1 // indirect
	github.com/mitchellh/go-homedir v1.1.0 // indirect
	github.com/moby/sys/mountinfo v0.7.2 // indirect
	github.com/moby/sys/userns v0.1.0 // indirect
	github.com/moby/term v0.5.2 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.3-0.20250322232337-35a7c28c31ee // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/natefinch/lumberjack v2.0.0+incompatible // indirect
	github.com/opencontainers/go-digest v1.0.0 // indirect
	github.com/opencontainers/image-spec v1.1.1 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/prometheus/client_golang v1.23.2 // indirect
	github.com/prometheus/client_model v0.6.2 // indirect
	github.com/prometheus/common v0.66.1 // indirect
	github.com/prometheus/procfs v0.17.0 // indirect
	github.com/rancher/dynamiclistener v0.7.5 // indirect
	github.com/rancher/lasso v0.2.5 // indirect
	github.com/rancher/wharfie v0.7.1 // indirect
	github.com/rancher/wrangler/v3 v3.3.4 // indirect
	github.com/rootless-containers/rootlesskit v1.1.1 // indirect
	github.com/russross/blackfriday/v2 v2.1.0 // indirect
	github.com/sirupsen/logrus v1.9.4 // indirect
	github.com/spf13/cobra v1.9.1 // indirect
	github.com/stoewer/go-strcase v1.3.0 // indirect
	github.com/urfave/cli/v2 v2.27.7 // indirect
	github.com/vbatts/tar-split v0.12.2 // indirect
	github.com/x448/float16 v0.8.4 // indirect
	github.com/xrash/smetrics v0.0.0-20240521201337-686a1a2994c1 // indirect
	go.etcd.io/etcd/api/v3 v3.6.8 // indirect
	go.etcd.io/etcd/client/pkg/v3 v3.6.8 // indirect
	go.etcd.io/etcd/client/v3 v3.6.8 // indirect
	go.etcd.io/raft/v3 v3.6.0 // indirect
	go.opentelemetry.io/auto/sdk v1.2.1 // indirect
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.60.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.63.0 // indirect
	go.opentelemetry.io/otel v1.40.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace v1.38.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc v1.38.0 // indirect
	go.opentelemetry.io/otel/metric v1.40.0 // indirect
	go.opentelemetry.io/otel/sdk v1.40.0 // indirect
	go.opentelemetry.io/otel/trace v1.40.0 // indirect
	go.opentelemetry.io/proto/otlp v1.7.1 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	go.uber.org/zap v1.27.1 // indirect
	go.yaml.in/yaml/v2 v2.4.3 // indirect
	golang.org/x/crypto v0.48.0 // indirect
	golang.org/x/exp v0.0.0-20251023183803-a4bb9ffd2546 // indirect
	golang.org/x/net v0.49.0 // indirect
	golang.org/x/oauth2 v0.34.0 // indirect
	golang.org/x/sync v0.19.0 // indirect
	golang.org/x/sys v0.41.0 // indirect
	golang.org/x/term v0.40.0 // indirect
	golang.org/x/text v0.34.0 // indirect
	golang.org/x/time v0.14.0 // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20251202230838-ff82c1b0f217 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20251202230838-ff82c1b0f217 // indirect
	google.golang.org/grpc v1.79.1 // indirect
	google.golang.org/protobuf v1.36.10 // indirect
	gopkg.in/evanphx/json-patch.v4 v4.13.0 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	gopkg.in/natefinch/lumberjack.v2 v2.2.1 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	k8s.io/api v0.34.5 // indirect
	k8s.io/apiserver v0.34.5 // indirect
	k8s.io/client-go v11.0.1-0.20190409021438-1a26190bd76a+incompatible // indirect
	k8s.io/cluster-bootstrap v0.33.9 // indirect
	k8s.io/component-helpers v0.34.5 // indirect
	k8s.io/controller-manager v0.34.5 // indirect
	k8s.io/kms v0.34.5 // indirect
	k8s.io/kube-openapi v0.0.0-20250910181357-589584f1c912 // indirect
	k8s.io/utils v0.0.0-20251002143259-bc988d571ff4 // indirect
	sigs.k8s.io/apiserver-network-proxy/konnectivity-client v0.31.2 // indirect
	sigs.k8s.io/json v0.0.0-20250730193827-2d320260d730 // indirect
	sigs.k8s.io/randfill v1.0.0 // indirect
	sigs.k8s.io/structured-merge-diff/v4 v4.7.0 // indirect
	sigs.k8s.io/yaml v1.6.0 // indirect
)
