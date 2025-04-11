# app/application/routers/base.py
from typing import Type, Callable, List, Any, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session

def create_base_router(
    prefix: str,
    tag: str,
    response_model: Type,
    schema_in: Type,
    service_get_all: Callable[[Session], List],
    service_upsert: Callable[[Session, dict], Any],
    service_get_by_id: Callable[[Session, Any], Any] = None,  # 👉 opcional
) -> APIRouter:
    router = APIRouter(prefix=prefix, tags=[tag])

    @router.get("/", response_model=List[response_model])
    def list_all(session: Session = Depends(get_session)):
        return service_get_all(session)

    if service_get_by_id:  # 👉 solo si se define
        @router.get("/{id_}", response_model=response_model)
        def get_by_id(id_: int, session: Session = Depends(get_session)):
            result = service_get_by_id(session, id_)
            if not result:
                raise HTTPException(status_code=404, detail="No encontrado")
            return result

    @router.post("/", response_model=response_model)
    def upsert(data: schema_in, session: Session = Depends(get_session)):
        return service_upsert(session, data.dict())

    return router
