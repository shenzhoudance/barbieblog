# 构建一个 barbieblog 博客

## 课前准备

Prerequisite（see links below）

+ Installed Ruby >= 2.0, Ruby on Rails >= 5.0, sqlite 3
+ Some Experience With Working With Terminal/Command line
+ A Text Editor > atom ,sublime ,aptana stuio(ide）
+ Git Version Control System

# SECTION 1 GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

```
mkdir workspace
cd workspace
rails new barbieblog

ls
cd barbieblog
atom .
rails server

git init
git status
git add .
git commit -m "initial commit"

git remote add origin https://github.com/shenzhoudance/barbieblog.git
git push -u origin master
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq45qbb7uij30wk0qm17q.jpg)


generate yout first controller,action,and view
make modifications to the routes file

+ we'll name the controller:welcome
+ we'll name the acttion & view:index

```
git checkout -b Welcome
rails generate controller Welcome index
rails server
http://localhost:3000/welcome/index
```
![image](https://ws2.sinaimg.cn/large/006tNc79gy1fq4613xu60j30qw09gwf8.jpg)
```
config/routes.rb
---
Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
end
---
rails server
http://localhost:3000
---
git status
git add .
git commit -m "added controller welcome and action,and view
make modified  routes to include root welcome#index"
git push origin Welcome
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq463pfjf9j30oy0a63z3.jpg)
