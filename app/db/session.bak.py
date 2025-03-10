from sqlmodel import SQLModel, create_engine, Session
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker
from contextlib import asynccontextmanager
from dotenv import load_dotenv
import os


# This will automatically load the .env file set by the `--env-file` option in uvicorn
load_dotenv()

# Read the connection parameters from environment variables
DB_HOST = os.getenv('DB_HOST')
DB_USER = os.getenv('DB_USER')
DB_PASS = os.getenv('DB_PASS')
DB_NAME = os.getenv('DB_NAME')
DB_PORT = os.getenv('DB_PORT')

# Create the async database URL
DATABASE_URL = f'postgresql+asyncpg://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}'

# Create the async engine
engine = create_async_engine(DATABASE_URL, echo=True)

# Async session maker
AsyncSessionLocal = sessionmaker(
    engine, class_=AsyncSession, expire_on_commit=False
)

# Async context manager for session
@asynccontextmanager
async def get_db():
    async with AsyncSessionLocal() as session:
        yield session
