from fastapi import FastAPI

# uvicorn main:app 의 app. nginx /app/ 이 여기로 들어옴
app = FastAPI()


# 브라우저: http://ALB/app/  → FastAPI /
@app.get("/")
def root():
    return {"message": "fastapi ok"}


# 브라우저: http://ALB/app/items
# DB 붙이면 여기 select 결과를 주면 됨
@app.get("/items")
def get_items():
    return [
        {"name": "홍길동", "class_name": "bipa17"},
    ]
