# FastAPI 이미지. compose 서비스 이름 fastapi, 포트 8000
# nginx default.conf 의 proxy_pass http://fastapi:8000/ 과 맞출 것
FROM python:3.9-slim

WORKDIR /app

# 로그가 바로 나오게. .pyc 안 만듦
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# 패키지부터 복사하면 requirements 안 바뀔 때 레이어 재사용
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

EXPOSE 8000

# --reload 는 개발용. ASG 운영 이미지에는 안 넣음
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
