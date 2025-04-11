# app/application/services/base_service.py
from typing import Callable, Any
from sqlmodel import Session

def get_all_service(repository_get_all: Callable[[Session], list]):
    def service(session: Session):
        return repository_get_all(session)
    return service

def get_by_id_service(repository_get_by_id: Callable[[Session, Any], Any]):
    def service(session: Session, id_: Any):
        return repository_get_by_id(session, id_)
    return service

def upsert_service(repository_get_by_id: Callable[[Session, Any], Any], 
                   repository_model: Any):
    def service(session: Session, obj_data: dict, id_field: str = "id"):
        obj_id = obj_data.get(id_field)
        existing = repository_get_by_id(session, obj_id)
        if existing:
            for key, value in obj_data.items():
                setattr(existing, key, value)
            session.add(existing)
        else:
            new_obj = repository_model(**obj_data)
            session.add(new_obj)
        session.commit()
        session.refresh(existing if existing else new_obj)
        return existing if existing else new_obj
    return service
