# 🚀 DailyKrate

**DailyKrate** is a production-ready Java Spring Boot microservices platform with centralized Helm/Kubernetes deployment. It features secure authentication, service discovery, and modular REST APIs — designed for cloud-native apps and rapid scaling.

---

## 🧰 What's Inside

- 🔐 `user-service` — JWT auth (register/login)
- 🌐 `api-gateway` — central entry point, routes traffic securely
- 🔍 `discovery-server` — Eureka service registry
- 📥 `getter-service` — reads data
- ✍️ `writer-service` — inserts data
- 🧠 `data-service` — custom logic
- 🗄️ PostgreSQL — shared via Helm
- ☸️ Central `helm/` folder — deploys everything

---

## 🗂️ Project Structure

```
dailykrate/
├── user-service/
├── api-gateway/
├── discovery-server/
├── getter-service/
├── writer-service/
├── data-service/
├── helm/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── user-service.yaml
│       ├── api-gateway.yaml
│       └── ...
```

---

## 🧪 How to Use

### 1️⃣ Build All Microservices

```bash
mvn clean install
```

### 2️⃣ Build and Push Docker Images

```bash
docker build -t paumicsul/user-service ./user-service
docker push paumicsul/user-service

# Repeat for each service...
```

### 3️⃣ Deploy to Kubernetes with Helm

```bash
helm upgrade --install dailykrate ./helm -n dailykrate --create-namespace
```

---

## 🔐 Security

- JWT-based auth via `user-service`
- Gateway protects downstream APIs
- Secrets injected via Kubernetes
- PostgreSQL managed externally but used by services

---

## 📚 API Documentation

Swagger UI is enabled on each service:

```
http://<service-ip>/swagger-ui.html
```

Access locally using `kubectl port-forward` or expose via ingress.

---

## 🤖 Future Additions

- Kafka support
- Observability stack (Prometheus + Grafana)
- Rate limiting & circuit breakers

---

## 📄 License

MIT — open for extension, sharing, and learning 🚀
