# hello_k8s

## On Web

- 打開瀏覽器
- 申請 [GCP account](https://cloud.google.com/)
- 進入 GCP console 主畫面
- 建立一個專案 `<YOUR_GCP_PROJECT>`
- 打開左上角的 Activative Google Gloud Shell


## On Shell

取得 code

```shell
$ git clone <this project>
```

設定 gcp config

```shell
$ gcloud config set compute/region asia-east1
$ gcloud config set compute/zone asia-east1-a
```

建立 clusters

```shell
gcloud container clusters create hello-k8s --enable-cloud-logging --enable-cloud-monitoring --machine-type g1-small --num-nodes 2
```

指定 `kubectl` 專案

```shell
$ gcloud container clusters get-credentials hello-k8s
```

紀錄 user

```shell
$ sed -i '' -e  "s/YOUR_NAME/$USER/g" ./html/index.html
```

建立要丟上去的 docker hub

```shell
$ docker build -t asia.gcr.io/<YOUR_GCP_PROJECT>/hello-k8s/app:v1 .
```

push

```shell
$ gcloud docker -- push asia.gcr.io/<YOUR_GCP_PROJECT>/hello-k8s/app:v1
```

設定 `web-deployment.yml`，修改 image 的值

```shell
$ vim ./web-deployment.yml
```

```yaml
      containers:
        - name: web
          image: asia.gcr.io/<YOUR_GCP_PROJECT>/hello-k8s/app:v1
          ports:
```

建立 pod

```shell
$ kubectl create -f ./web-deployment.yml
```

[option] 更新 pod

```shell
$ kubectl apply -f ./web-deployment.yml
```

申請 GCP 靜態 IP

```shell
$ gcloud compute addresses create hello-k8s --region=asia-east1
```

記錄該 IP

```shell
$ gcloud compute addresses list
NAME             REGION       ADDRESS    STATUS
hello-k8s        asia-east1   YOUR_IP    pending
```

修改 `web-service.yml` ，將 `YOUR_IP` 取代之

```yaml
spec:
  type: LoadBalancer
  # use your external IP here
  loadBalancerIP: YOUR_IP
```

建立 service

```shell
$ kubectl create -f ./web-service.yml
```

更新 service

```shell
$ kubectl apply -f ./web-service.yml
```

## 打開瀏覽器，輸入 YOUR_IP

