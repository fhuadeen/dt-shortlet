import sys,os
BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, BASE)
import logging


# logging configuration
LOG_FORMAT = logging.Formatter("%(levelname)s:    %(asctime)s: %(module)s - %(message)s")

def logger_config(name, log_file_path, level=logging.DEBUG):
    """To set up logging configuration"""
    file_handler = logging.FileHandler(log_file_path)
    stream_handler = logging.StreamHandler(sys.stdout)
    file_handler.setFormatter(LOG_FORMAT)
    stream_handler.setFormatter(LOG_FORMAT)

    logger = logging.getLogger(name)
    logger.setLevel(level)
    logger.addHandler(file_handler)
    logger.addHandler(stream_handler)

    return logger
