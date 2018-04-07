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
clear
git status
git add .
git commit -m "added controller welcome and action,and view
make modified  routes to include root welcome#index"
git push origin Welcome
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq463pfjf9j30oy0a63z3.jpg)
![image](https://ws4.sinaimg.cn/large/006tNc79gy1fq468w3tblj31hm0xown3.jpg)

make out blog funtionality
create controller,action,and view independently
modify the routes file
tracing through errors!!

# SECTION 2 GETTING STARTHD WITH RAILS
based on guides.rubyonrails.org
```
git checkout -b Articles
---
config/routes.rb
---
Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  resources :articles
end

rails generate controller Articles
rails server
http://localhost:3000/articles/new
---
app/controllers/articles_controller.rb
---
class ArticlesController < ApplicationController
  def new
 end
end
---
app/views/articles/new.html.erb
---
<h1>New A Articles</h1>
---
```
![image](https://ws2.sinaimg.cn/large/006tNc79gy1fq46osf75yj30im062mxi.jpg)

```
git status
git add .
git commit -m "added resources for articles controller and views articles new"
```

embed ruby
froms in RAILS
understanding routes
will be tracing errors

```
app/views/articles/new.html.erb
---
<h1>Create A new Articles</h1>
<%= form_for :article do |f| %>
  <p>
    <%= f.label :title %> <br>
    <%= f.text_field :title  %>
  </p>
  <p>
    <%= f.label :text %> <br>
    <%= f.text_area :text %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>
---
```
![image](https://ws1.sinaimg.cn/large/006tNc79gy1fq47clraxxj30sy0dmwfb.jpg)

```
class ArticlesController < ApplicationController
  def new
  end

  def create
    render plain: params[:article].inspect
  end
end
---

app/views/articles/new.html.erb
---
<h1>Create A  new Articles</h1>
<%= form_for :article, url: articles_path do |f| %>
  <p>
    <%= f.label :title %> <br>
    <%= f.text_field :title  %>
  </p>
  <p>
    <%= f.label :text %> <br>
    <%= f.text_area :text %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>
---
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq47lo5e00j319a078dgt.jpg)

```
git status
git add .
git commit -m "add create controller & edit articles new"
git push origin Articles
```
![image](https://ws1.sinaimg.cn/large/006tNc79gy1fq47px9jrtj31fi0vq10h.jpg)


create a model
migrate to database
more routes,actions, & views
hopefully no errors

# SECTION 3 GETTING STARTED WITH Rails
BASED ON GUIDES.RUBYONRAILS.ORG

```
git checkout -b Aritcle-model
rails generate model Article title:string text:text
rake db:migrate
```
