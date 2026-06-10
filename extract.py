import requests
import dotenv as env
import os

env.load_dotenv()

def github_api():
    url='https://api.github.com/search/repositories'

    params={
        "q":"stars>1000 created:>2024-01-01",
        "sort":"stars",
        "order":"desc",
        "per_page":10
    }

    headers={"Authorization":f"token {os.getenv('GITHUB_TOKEN')}"}


    response=requests.get(url,params=params,headers=headers)


    if response.status_code!=200:
        print(f"[ERROR] Github API returned status {response.status_code}")
        raise Exception(f"Github Api error :{response.status_code}")

    data=response.json()

    if "items" not in data:
        raise Exception(f"[ERROR] Unexpected error : {data}")

    print(f"[SUCCESS] Fetched {len(data['items'])} repositories")

    return data["items"]