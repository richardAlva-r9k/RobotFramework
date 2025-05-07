import configparser
import os


class ConfigReader:
    def __init__(self, path='data/users_csx_bbdd.cfg'):
        # Calcular la ruta absoluta al archivo .cfg
        base_path = os.path.dirname(__file__)
        full_path = os.path.abspath(os.path.join(base_path, '..', path))

        self.config = configparser.ConfigParser()
        self.config.read(full_path)

    def get_config(self, key, section='database'):
        return self.config.get(section, key)
    