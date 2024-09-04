from fastapi import FastAPI
from datetime import datetime
import pytz

app = FastAPI(
    title="Shortlet App",
    description="API for the Shortlet App",
    version="1.0.0",
)

def get_current_datetime(timezone: str = "UTC"):

    try:
        tz = pytz.timezone(timezone)
    except pytz.UnknownTimeZoneError:
        return {"error": "Unknown timezone"}

    current_time = datetime.now(tz)
    return current_time
# isoformat()


# current_datetime/
@app.get("/")
def show_current_datetime():

    current_time: datetime = get_current_datetime()

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
