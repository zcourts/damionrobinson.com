realpath () {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
base=$(dirname `realpath $0`)
build="${base}/_site"
echo ${build}

#build the static site
jekyll build

#get the last commit message to use for the docs commit
commit_message=$(git log -1 HEAD --pretty=format:%s)

#create and move into the docs dir
cd ${build}/_site
echo $(pwd)

# get existing docs
git init
git remote add origin git@github.com:$2/damionrobinson.com.git
git checkout -b gh-pages
git pull origin gh-pages

echo $(pwd)
git add --all
git commit -m "${commit_message}"
git push origin gh-pages
