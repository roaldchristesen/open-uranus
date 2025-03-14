from typing import Annotated

from fastapi import FastAPI
from fastapi.security import OAuth2PasswordBearer
from fastapi.staticfiles import StaticFiles

from app.api.v1.endpoints import user, venue, event, space, space_type, venue_type, event_type, genre_type


app = FastAPI(title='Veranstaltungen finden')
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
app.mount('/static', StaticFiles(directory='static'), name='static')


app.include_router(user.router, prefix='/user', tags=['Nutzerverwaltung'])
app.include_router(venue.router, prefix='/venue', tags=['Veranstaltungsorte'])
app.include_router(venue_type.router, prefix='/venue/type', tags=['Veranstaltungsorte'])
app.include_router(event.router, prefix='/event', tags=['Veranstaltungen'])
app.include_router(event_type.router, prefix='/event/type', tags=['Veranstaltungen'])
app.include_router(space.router, prefix='/space', tags=['Veranstaltungsräume'])
app.include_router(space_type.router, prefix='/space/type', tags=['Veranstaltungsräume'])
app.include_router(genre_type.router, prefix='/genre/type', tags=['Genre'])
