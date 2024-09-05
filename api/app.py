from datetime import datetime
# import os
# import sys

# BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# sys.path.insert(0, BASE)

from fastapi import FastAPI, Query, HTTPException
import pytz

from logs.logger_config import logger_config

import os
print(os.getcwd())

# set up logging
logger = logger_config("app_logs", f"./logs/app.log")

app = FastAPI(
    title="Shortlet App",
    description="API for the Shortlet App",
    version="1.0.0",
)

SUPPORTED_TIMEZONES = {
    "UTC": "UTC",
    "WAT": "Africa/Lagos",
    "GMT": "GMT",
    "EAT": "Africa/Nairobi",
}

def get_current_datetime(timezone: str = "UTC"):
    """
    Gets the current datetime of a given timezone

    Args:
        timezone (str, optional): Timezone to retrieve datetime for. Defaults to "UTC".

    Raises:
        Exception: If unknown timezone is provided

    Returns:
        _type_: datetime
    """
    tz = SUPPORTED_TIMEZONES.get(timezone)
    print("tz", tz)

    try:
        tz = pytz.timezone(tz)
    except pytz.UnknownTimeZoneError:
        raise Exception(f"Unknown timezone! Supported timezones: {list(SUPPORTED_TIMEZONES.keys())}")

    current_time = datetime.now(tz)
    return current_time

@app.get("/")
def show_current_datetime(timezone: str = Query(default="UTC")):

    try:
        current_time: datetime = get_current_datetime(timezone)
    except Exception as err:
        raise HTTPException(
            status_code=400,
            detail=str(err)
        )

    return {"Current time": current_time.isoformat()}
    # return {
    #     "year": current_time.year,
    #     "month": current_time.month,
    #     "day": current_time.day,
    #     "hour": current_time.hour,
    #     "minute": current_time.minute,
    #     # "seconds": current_time.seconds,
    # }

# Run the application with: uvicorn api.app:app --reload
