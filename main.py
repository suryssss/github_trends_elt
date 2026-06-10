from extract import github_api
from load import get_engine,load_to_postgres


def main():
    repos=github_api()
    engine=get_engine()
    load_to_postgres(repos,engine)

if __name__=="__main__":
    main()