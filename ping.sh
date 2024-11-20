echo ''
echo 'Spring Boot'
echo ''
curl http://localhost:8001/health
curl http://localhost:8002/health
curl http://localhost:8003/health
curl http://localhost:8004/health
curl http://localhost:8005/health

echo ''
echo 'Gin'
echo ''
curl http://localhost:8101/health
curl http://localhost:8102/health
curl http://localhost:8103/health
curl http://localhost:8104/health

echo ''
echo 'FastAPI'
echo ''
curl http://localhost:8201/health
curl http://localhost:8202/health
curl http://localhost:8203/health

echo ''
echo 'Actix'
echo ''
curl http://localhost:8301/health
curl http://localhost:8302/health