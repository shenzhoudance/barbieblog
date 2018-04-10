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
based on guides.rubyonrails.org

```
git checkout -b Aritcle-model
rails generate model Article title:string text:text
rake db:migrate
git status
git add .
git commit -m "generated to model articles and migrated the database"
```
![image](https://ws4.sinaimg.cn/large/006tNc79gy1fq4ag67mtaj31kw10vguz.jpg)

section 3b
saving date in the controller
model - view - controller
communication
```
app/controllers/articles_controller.rb
---
class ArticlesController < ApplicationController
  def new
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end

  end
  ---
  app/views/articles/show.html.erb
  ---
  <p><strong>title</strong>
    <%= @article.title %>
  </p>

  <p><strong>Text:</strong>
      <%= @article.text %>
  </p>
---
```
http://localhost:3000/articles/new
http://localhost:3000/articles/3
![image](https://ws4.sinaimg.cn/large/006tNc79gy1fq4aw1bt7xj30lk0723z4.jpg)
```
git status
git add .
git commit -m "edited show and create actions"
git push origin Aritcle-model  
```
![image](https://ws2.sinaimg.cn/large/006tNc79gy1fq4ayrmtq2j31ek0nyjxf.jpg)

index action and view list all articles_path
create links between all pages
deeper route understanding
hopefully no errors

# SECTION 3 GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

```
app/controllers/articles_controller.rb
---
class ArticlesController < ApplicationController
  def index
    @article = Article.all
    end

  def new
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end

  end
  ---
  app/views/articles/show.html.erb
  ---
  <p><strong>title</strong>
    <%= @article.title %>
  </p>

  <p><strong>Text:</strong>
      <%= @article.text %>
  </p>

  <p>
  <%= link_to 'back', articles_path %>
  <%= link_to 'home', welcome_index_path %>
  </p>
---
app/views/articles/index.html.erb
---

<h1>list of all article</h1>
  <table>
    <tr>
      <th>title</th>
      <th>text</th>
    <tr>

  <% @article.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= truncate(article.text, length: 75) %></td>
      <td><%= link_to 'show', article_path(article) %></td>
    </tr>
    <% end %>
</table>

<p>
<%= link_to 'home', welcome_index_path %>
<%= link_to 'new', new_article_path %>
</p>
---
app/views/welcome/index.html.erb
---
<h1>Welcome to My Blog</h1>
<p><%= link_to 'My Blog', articles_path %></p>
---
```
![image](https://ws2.sinaimg.cn/large/006tNc79gy1fq4c0dqcqgj30r609ajs0.jpg)
![image](https://ws1.sinaimg.cn/large/006tNc79gy1fq4c0iwi25j30qa0cc0tu.jpg)
![image](https://ws4.sinaimg.cn/large/006tNc79gy1fq4c07eaylj30j008kdgj.jpg)
```
clear
git status
git add .
git commit -m "added index action and template,created a list of blog entries in template index, created links between pages"
git push origin Aritcle-model
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq4bw1gbo7j31kg0xmguq.jpg)

edit article
delete article
routes,action,and views
a few mode links
some errors


# SECTION 5
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org
```
app/controllers/articles_controller.rb
---
class ArticlesController < ApplicationController
  def index
    @article = Article.all
    end

  def new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
      @article = Article.find(params[:id])
  end

  def update
      @article = Article.find(params[:id])
      if @article.update(article_params)
         redirect_to @article
      else
        render 'edit'
    end
  end



  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end

  end
---
app/views/articles/index.html.erb
---

<h1>list of all article</h1>
  <table>
    <tr>
      <th>title</th>
      <th>text</th>
    <tr>

  <% @article.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= truncate(article.text, length: 75) %></td>
      <td><%= link_to 'show', article_path(article) %></td>
      <td><%= link_to 'edit', edit_article_path(article) %></td>
      <td><%= link_to 'Delete',article_path(article),
               method: :delete,
               data: { confirm: 'Are you sure?' } %>
       </td>
    </tr>
    <% end %>
</table>

<p>
<%= link_to 'home', welcome_index_path %>
<%= link_to 'new', new_article_path %>
</p>
---
app/views/articles/edit.html.erb
---
<h1>edit Articles</h1>
<%= form_for @article do |f| %>
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
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq4eyvj4ouj30ok0au3zi.jpg)
```
git status
git add .
git commit -m "add edit and delete article"
git push origin Aritcle-model
```
![image](https://ws4.sinaimg.cn/large/006tNc79gy1fq4ewvqqtsj31d80sc45f.jpg)


create the ability to comment
generate model & controller
creating associations
actions,form,show comments
model links between pages
hopefully no errors

# SECTION 6
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

```
git checkout -b comment
rails generate model Comment commenter:string body:text article:references
rake db:migrate
--
app/models/article.rb
---
class Article < ApplicationRecord
  has_many :comments
end
---
config/routes.rb
---
Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  resources :articles do
    resources :comments
  end
end
---
app/views/articles/show.html.erb
---
<p><strong>title</strong>
  <%= @article.title %>
</p>

<p><strong>Text:</strong>
    <%= @article.text %>
</p>

<h2> add comment</h2>
<%= form_for([@article,@article.comments.build]) do |f| %>
<p>
  <%= f.label :commenter %>
  <%= f.text_field :commenter %>
</p>

<p>
  <%= f.label :body %>
  <%= f.text_area :body %>
</p>

<p>
  <%= f.submit %>
</p>
  <% end %>


<p>
<%= link_to 'back', articles_path %>
<%= link_to 'home', welcome_index_path %>
</p>
---
```
![image](https://ws1.sinaimg.cn/large/006tNc79gy1fq4glvmqifj30oo0g2gmj.jpg)


need to look at the
routes for the comments
to find right
actions and paths
```
app/controllers/comments_controller.rb
---
class CommentsController < ApplicationController

 def create
   @article = Article.find(params[:article_id])
   @comment = @article.comments.create(comment_params)
   redirect_to article_path(@article)
 end


private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
---
app/views/articles/show.html.erb
---
<p><strong>title</strong>
  <%= @article.title %>
</p>

<p><strong>Text:</strong>
    <%= @article.text %>
</p>

<hr>
<h2> comments </h2>
<% @article.comments.each do |comment| %>

<p>
<strong>commenter:</strong>
<%= comment.commenter %>
</p>


<p>
<strong> comment</strong>
<%= comment.body %>
</p>

<% end %>





<h2> add comment</h2>
<%= form_for([@article,@article.comments.build]) do |f| %>
<p>
  <%= f.label :commenter %>
  <%= f.text_field :commenter %>
</p>

<p>
  <%= f.label :body %>
  <%= f.text_area :body %>
</p>

<p>
  <%= f.submit %>
</p>
  <% end %>


<p>
<%= link_to 'back', articles_path %>
<%= link_to 'home', welcome_index_path %>
</p>

```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq4hwcrugkj30p40mqgmv.jpg)
```
git status
git add .
git commit -m "generate model comment and controller comments"
git push origin comment
```
![image](https://ws4.sinaimg.cn/large/006tNc79gy1fq4hy7g4zuj31jq12e484.jpg)


deliting comments
adding form validations
errors

# SECTION 7
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

```
app/controllers/comments_controller.rb
---
class CommentsController < ApplicationController

 def create
   @article = Article.find(params[:article_id])
   @comment = @article.comments.create(comment_params)
   redirect_to article_path(@article)
 end


 def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)

 end

private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
---
app/views/articles/show.html.erb
---
<p><strong>title</strong>
  <%= @article.title %>
</p>

<p><strong>Text:</strong>
    <%= @article.text %>
</p>

<hr>
<h2> comments </h2>
<% @article.comments.each do |comment| %>

<p>
<strong>commenter:</strong>
<%= comment.commenter %>
</p>


<p>
<strong> comment</strong>
<%= comment.body %>
</p>

<p>
  <%= link_to 'Delete comment',[comment.article, comment],
           method: :delete,
           data: { confirm: 'Are you sure?' } %>
</p>

<% end %>





<h2> add comment</h2>
<%= form_for([@article,@article.comments.build]) do |f| %>
<p>
  <%= f.label :commenter %>
  <%= f.text_field :commenter %>
</p>

<p>
  <%= f.label :body %>
  <%= f.text_area :body %>
</p>

<p>
  <%= f.submit %>
</p>
  <% end %>


<p>
<%= link_to 'back', articles_path %>
<%= link_to 'home', welcome_index_path %>
</p>
---
app/models/article.rb
---
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
end
---
```
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq4yj2z6xij30l40o60tv.jpg)

```
git status
git add .
git commit -m "added the ability to destroy a comments"
git push origin comment
```
![image](https://ws4.sinaimg.cn/large/006tKfTcgy1fq4yq04a84j31fg0m6wk9.jpg)

form validation
requirements on a form
to be submitted
```
app/models/article.rb
---
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
              length: {minimum: 3}
  validates :text, presence: true,
              length: {minimum: 2}
end
---
app/controllers/articles_controller.rb
---
class ArticlesController < ApplicationController
  def index
    @article = Article.all
    end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
      @article = Article.find(params[:id])
  end

  def update
      @article = Article.find(params[:id])
      if @article.update(article_params)
         redirect_to @article
      else
        render 'edit'
    end
  end



  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
    redirect_to @article
   else
    render 'new'
   end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end

  end
---
app/views/articles/new.html.erb
---
<h1>Create A  new Articles</h1>
<%= form_for :article, url: articles_path do |f| %>

<!-- checking for errors -->
<% if @article.errors.any? %>
<div id="error_explanation">
  <h2>
    <%= pluralize(@article.errors.count, "error") %>
     prohibited this article from being saved:
   </h2>
    <p>
   <ul>
     <% @article.errors.full_messages.each do |msg| %>
     <li>
       <%= msg %>
     </li>
   </ul>
      <% end %>
    </p>
</div>
      <% end %>
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

<p>
<%= link_to 'back', articles_path %>
<%= link_to 'home', welcome_index_path %>
</p>

```
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq4znyg93sj30w00my763.jpg)
```
git status
git add .
git commit -m "added vaildations to create article"
git push origin comment
```
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq4znohn1bj31ea0nq44k.jpg)

creating partials
adding created at times
adding basic security
errors!!!
next time -bootstarp 4!!

# SECTION 8
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

creating partials
snippits of html/ruby code stored
in one html.erb file and called
upon in another html.erb file

```
git checkout -b partials-form
---
app/views/articles/show.html.erb
---

<p><strong>title</strong>
  <%= @article.title %>
</p>
<p><strong>TIME:</strong>
    <%= @article.created_at %>
</p>

<p><strong>Text:</strong>
    <%= @article.text %>
</p>

<hr>
<%= render 'comments/comment' %>
<hr>
<%= render 'comments/form' %>

<p>
<%= link_to 'back', articles_path %>
<%= link_to 'home', welcome_index_path %>
</p>
---
app/views/comments/_form.html.erb
---
<!-- form partial for comments -->
<h3> The Rendered Form</h3>
<h2> add comment</h2>
<%= form_for([@article,@article.comments.build]) do |f| %>
<p>
  <%= f.label :commenter %>
  <%= f.text_field :commenter %>
</p>

<p>
  <%= f.label :body %>
  <%= f.text_area :body %>
</p>

<p>
  <%= f.submit %>
</p>
  <% end %>
---
app/views/comments/_comment.html.erb
---
<h3> Comment Partial </h3>

<h2> comments </h2>
<% @article.comments.each do |comment| %>

<p>
<strong>commenter:</strong>
<%= comment.commenter %>
</p>
<p><strong>TIME:</strong>
    <%= comment.created_at %>
</p>

<p>
<strong> comment</strong>
<%= comment.body %>
</p>

<p>
  <%= link_to 'Delete comment',[comment.article, comment],
           method: :delete,
           data: { confirm: 'Are you sure?' } %>
</p>

<% end %>
---
```
![image](https://ws1.sinaimg.cn/large/006tKfTcgy1fq514h898pj30ls0usdhq.jpg)

basic http
authenication
preventing visitors from
creating,editing,deleting articles
add deleting comments
```
app/controllers/articles_controller.rb
---
class ArticlesController < ApplicationController
http_basic_authenticate_with name: "xiaowei", password: "123456",
except: [:index, :show]

  def index
    @article = Article.all
    end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
      @article = Article.find(params[:id])
  end

  def update
      @article = Article.find(params[:id])
      if @article.update(article_params)
         redirect_to @article
      else
        render 'edit'
    end
  end



  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
    redirect_to @article
   else
    render 'new'
   end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end

  end
---
app/controllers/comments_controller.rb
---
class CommentsController < ApplicationController
  http_basic_authenticate_with name: "xiaowei", password: "12345678",
  except: [:index, :show]

 def create
   @article = Article.find(params[:article_id])
   @comment = @article.comments.create(comment_params)
   redirect_to article_path(@article)
 end


 def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)

 end

private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
---
```
```
git status
git add .
git commit -m "made partials of comment form & http security"
git push origin partials-form
```
![image](https://ws4.sinaimg.cn/large/006tKfTcgy1fq51mkwhwwj31ke0n2tbu.jpg)
![image](https://ws4.sinaimg.cn/large/006tKfTcgy1fq51l2wrxpj31k00t4jze.jpg)


bootstarp 4
adding gems
modefy assets
styles and js files

# SECTION 9
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

```
git checkout -b bootstrap
https://rubygems.org/gems/bootstrap
https://rubygems.org/gems/sprockets-rails
gem 'bootstrap', '~> 4.0'
gem install bootstrap
gem 'sprockets-rails', '~> 3.2', '>= 3.2.1'
gem install sprockets-rails
bundle installl
```
```
app/assets/stylesheets/application.scss
---
@import "bootstrap";

app/assets/javascripts/application.js
---
//= require rails-ujs
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .
---
```
![image](https://ws1.sinaimg.cn/large/006tKfTcgy1fq52uyrqjwj30oa0do403.jpg)
![image](https://ws3.sinaimg.cn/large/006tKfTcgy1fq52v3b7m5j30r20fumys.jpg)
1、paste
gem 'jquery-rails','~> 4.3', '>= 4.3.1'
into the gemfile
2、paste
gem install jquery-rails
into the Terminal
3、in the terminl type
bundle install
to make use of the gem


```
git status
git add .
git commit -m "added bootstrap gem and sprockets gem and updated bundle and added bootstarp to scss and js files "
git push origin bootstarp
```
![image](https://ws3.sinaimg.cn/large/006tKfTcgy1fq52wcvnp0j31d40c6q6i.jpg)

# SECTION 10
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

```
git checkout -b bootstrap-buttins
app/views/layouts/application.html.erb
---
<!DOCTYPE html>
<html>
  <head>
    <title>Barbieblog</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <div class="container">
    <%= yield %>
    </div>
  </body>
</html>
---
app/views/welcome/index.html.erb
---
<div class="row" style="padding-top:20%;">
  <div class="col"></div>
  <div class="col-md-7 text-center">
    <h1>欢迎来到才华横溢的世界</h1>
    <p><%= link_to '进入我的世界', articles_path, class: "btn btn-lg btn-danger" %></p>
  </div><!-- col-md-7 -->
   <div class="col"></div>
</div><!-- row -->
---
app/views/comments/_comment.html.erb
---
<h3> Comment Partial </h3>

<h2> comments </h2>
<% @article.comments.each do |comment| %>

<p>
<strong>commenter:</strong>
<%= comment.commenter %>
</p>
<p><strong>TIME:</strong>
    <%= comment.created_at %>
</p>

<p>
<strong> comment</strong>
<%= comment.body %>
</p>

<p>
  <%= link_to 'Delete comment',[comment.article, comment],
           class:'btn btn-sm btn-danger',
           method: :delete,
           data: { confirm: 'Are you sure?' } %>
</p>

<% end %>
---
app/views/comments/_form.html.erb
---
<!-- form partial for comments -->
<h3> The Rendered Form</h3>
<h2> add comment</h2>
<%= form_for([@article,@article.comments.build]) do |f| %>
<div class="field" style="100%;">

</div>

<p>
  <%= f.label :commenter %>
  <%= f.text_field :commenter, class: "form-control" %>
</p>

<p>
  <%= f.label :body %>
  <%= f.text_area :body, class: "form-control" %>
</p>

<p>
  <%= f.submit class: "btn btn-lg btn-success" %>
</p>
  <% end %>
---
```
```
app/views/articles/index.html.erb
---
<div class="row">
  <div class="col"></div>
    <div class="col-md-10">

<h1>list of all article</h1>
<p>
  <%= link_to 'Create NEW Article', new_article_path, class:'btn btn-lg btn-info' %>
</p>
  <table class="table table-hover">
    <tr>
      <th>title</th>
      <th>text</th>
      <th colspan="3">Editing option</th>
    <tr>

  <% @article.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= truncate(article.text, length: 75) %></td>
      <td><%= link_to 'show', article_path(article), class:'btn btn-sm btn-info' %></td>
      <td><%= link_to 'edit', edit_article_path(article), class:'btn btn-sm btn-warning' %></td>
      <td><%= link_to 'Delete',article_path(article),
               method: :delete,
               data: { confirm: 'Are you sure?' } ,class:'btn btn-sm btn-danger'%>
       </td>
    </tr>
    <% end %>
</table>

<p>
<%= link_to 'home', welcome_index_path, class:'btn btn-sm btn-primary' %>
<%= link_to 'new', new_article_path %>
</p>

</div><!-- col-md-10 -->
 <div class="col"></div>
</div><!-- row -->
---
app/views/articles/new.html.erb
---
<div class="row" style="padding-top:10%;">
  <div class="col"></div>
    <div class="col-md-7">

      <h1>Create A  new Articles</h1>
<%= form_for :article, url: articles_path do |f| %>
<div class="field" style="100%;">
<!-- checking for errors -->
<% if @article.errors.any? %>
<div id="error_explanation">
  <h2>
    <%= pluralize(@article.errors.count, "error") %>
     prohibited this article from being saved:
   </h2>
    <p>
   <ul>
     <% @article.errors.full_messages.each do |msg| %>
     <li>
       <%= msg %>
     </li>
   </ul>
      <% end %>
    </p>

</div>
      <% end %>
  <p>
    <%= f.label :title %> <br>
    <%= f.text_field :title, class: "form-control" %>
  </p>
  <p>
    <%= f.label :text %> <br>
    <%= f.text_area :text, class: "form-control"  %>
  </p>
  <p>
    <%= f.submit class: "btn btn-lg btn-success" %>
  </p>

</div><!-- field -->
<% end %>

<p>
<%= link_to 'Back', articles_path, class:'btn btn-md btn-info' %>
<%= link_to 'Home', welcome_index_path, class:'btn btn-md btn-primary' %>
</p>

</div><!-- col-md-7 -->
 <div class="col"></div>
</div><!-- row -->
---
app/views/articles/show.html.erb
---
<div class="row">
  <div class="col"></div>
    <div class="col-md-7">

<p><strong>title</strong>
  <%= @article.title %>
</p>
<p><strong>TIME:</strong>
    <%= @article.created_at %>
</p>

<p><strong>Text:</strong>
    <%= @article.text %>
</p>

<hr>
<%= render 'comments/comment' %>
<hr>
<%= render 'comments/form' %>


<p>
<%= link_to 'Back', articles_path, class:'btn btn-md btn-info' %>
<%= link_to 'Home', welcome_index_path, class:'btn btn-md btn-primary' %>
</p>

</div><!-- col-md-7 -->
 <div class="col"></div>
</div><!-- row -->
---
app/views/articles/edit.html.erb
---
<div class="row" style="padding-top:10%;">
  <div class="col"></div>
    <div class="col-md-7">
      <h1>edit Articles</h1>
      <%= render 'form' %>
</div><!-- col-md-7 -->
 <div class="col"></div>
</div><!-- row -->
---
app/views/articles/_form.html.erb
<%= form_for @article do |f| %>
  <p>
    <%= f.label :title %> <br>
    <%= f.text_field :title, class: "form-control"  %>
  </p>
  <p>
    <%= f.label :text %> <br>
    <%= f.text_area :text, class: "form-control" %>
  </p>
  <p>
    <%= f.submit class: "btn btn-lg btn-success" %>
  </p>
<% end %>
---
```
```
app/assets/stylesheets/application.scss
---
@import "bootstrap";
.container
{
  padding-top:15px;
}

thead
{
  background-color: #dddddd;
}

.form-control
{
  background-color: #efeeef;
  border: 2px solid #eeccdd;
}
---
```
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq5atjz892j31kw0kqjtj.jpg)
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq5atduy4yj31kw0rhjuz.jpg)
![image](https://ws1.sinaimg.cn/large/006tKfTcgy1fq5at7dse0j31kw0n5dhx.jpg)
![image](https://ws1.sinaimg.cn/large/006tKfTcgy1fq5asqqkmqj31kw0xojvv.jpg)

```
git status
git add .
git commit -m "style with bootstrap - basic"
git push origin bootstrap-buttins
```

bootstrap
download the bootstrap framework
simple bootstrap theme
edit the navigation bar + other editing
using firefox - not chrome

getbootstrap.com
bootstrap/docs/4.0/examples/navbar-fixed
file:///Users/xiaowei/Downloads/bootstrap-4.0.0%202/docs/4.0/examples/navbar-fixed/index.html
```
index.html
---
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../../../favicon.ico">

    <title>Fixed top navbar example for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="navbar-top-fixed.css" rel="stylesheet">
  </head>

  <body>

    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
      <a class="navbar-brand" href="#">Fixed navbar</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Link</a>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled" href="#">Disabled</a>
          </li>
        </ul>
        <form class="form-inline mt-2 mt-md-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
      </div>
    </nav>

    <main role="main" class="container">
      <div class="jumbotron">
        <h1>Navbar example</h1>
        <p class="lead">This example is a quick exercise to illustrate how fixed to top navbar works. As you scroll, it will remain fixed to the top of your browser's viewport.</p>
        <a class="btn btn-lg btn-primary" href="../../components/navbar/" role="button">View navbar docs &raquo;</a>
      </div>
    </main>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="../../../../assets/js/vendor/popper.min.js"></script>
    <script src="../../../../dist/js/bootstrap.min.js"></script>
  </body>
</html>
```
```
navbar-top-fixed.css
---
/* Show it is fixed to the top */
body {
  min-height: 75rem;
  padding-top: 4.5rem;
}
```
![image](https://ws4.sinaimg.cn/large/006tKfTcgy1fq5c1ktmq7j31kw0j7dj5.jpg)
![image](https://ws4.sinaimg.cn/large/006tKfTcgy1fq5c2qhbzsj30rc0kowfg.jpg)
```
app/views/shared/_navigation.html.erb
---
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="#">Fixed navbar</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li>
    </ul>
    <form class="form-inline mt-2 mt-md-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
      <button class="btn btn-ligth my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
---
app/views/layouts/application.html.erb
---
<!DOCTYPE html>
<html>
  <head>
    <title>Barbieblog</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'shared/navigation'%>
    <div class="container">
    <%= yield %>
    </div>
  </body>
</html>
---
```
```
app/assets/stylesheets/navigation.scss
---
.navbar
{
  background-color: #f31346 !important;
}

.nav-link
{

}

.nav-item a
{
  font-weight: bold;
  color: #f3cace;
}

.nav-item a:hover
{
  font-weight: bold;
  color: #ffffff;
}

.navbar-toggler
{
  border: 2px solid #ffffff !important;
}
---
app/assets/stylesheets/application.scss
---
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, or any plugin's
 * vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 *= require_tree .
 *= require_self
 */
@import "bootstrap";
@import "welcome";
@import "navigation";


body {
  min-height: 75rem;
  padding-top: 4.5rem;
}

.container
{
  padding-top:15px;
}


thead
{
  background-color: #dddddd;
}

.form-control
{
  background-color: #efeeef;
  border: 3px solid #f3b1c8;
}

.btn-light
{
border: 3px solid #f3b1c8;
}
---
app/assets/stylesheets/welcome.scss
---
.btn-welcome
{
  background-color: #ff0055;
  color: #efeeef
}

.btn-welcome.hover
{
  background-color: #ff0044;
  color: #ffffff;
}

h1
{
  margin-bottom: 20px;
}
```
![image](https://ws1.sinaimg.cn/large/006tKfTcgy1fq5dautfxtj31kw0jnmz9.jpg)

```
git add .
git commit -m "add nav & edit color
git push origin nav
```
![image](https://ws3.sinaimg.cn/large/006tKfTcgy1fq5dd7y03sj31bw0iegqo.jpg)

one more bootstrap session
then back to ruby on rails development


bootstrap 4
convert navigation links to therubyracer
add image csrf_meta_tag
edit created_at times format
will be using firefox - not chrome


# SECTION 11 - part 2
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

```
app/views/shared/_navigation.html.erb
---
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="#">xiaoweiblog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
      <%= link_to 'Home', welcome_index_path, class:'nav-link' %>
      </li>
      <li class="nav-item">
        <%= link_to 'Blog', articles_path, class:'nav-link' %>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">About</a>
      </li>
    </ul>
    <form class="form-inline mt-2 mt-md-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
      <button class="btn btn-ligth my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
---
app/views/welcome/index.html.erb
---
<div class="row" style="padding-top:8%;">
  <div class="col"></div>
  <div class="col-md-7 text-center">
    <%= image_tag 'YAN-JIANG.jpg', style:"width:100%" %>
    <div class="jumbotron">


    <h1>欢迎来到才华横溢的世界</h1>
    <p><%= link_to '进入我的世界', articles_path, class: "btn btn-lg btn-welcome" %></p>
      </div><!-- jumbotron -->
    </div><!-- col-md-7 -->
   <div class="col"></div>
</div><!-- row -->
---
```
```
app/views/comments/_form.html.erb
---
<!-- form partial for comments -->
<h3> The Rendered Form</h3>
<h4> add comment</h4>
<%= form_for([@article,@article.comments.build]) do |f| %>
<div class="field" style="100%;">

</div>

<p>
  <%= f.label :commenter %>
  <%= f.text_field :commenter, class: "form-control" %>
</p>

<p>
  <%= f.label :body %>
  <%= f.text_area :body, class: "form-control" %>
</p>

<p>
  <%= f.submit class: "btn btn-lg btn-success" %>
</p>
  <% end %>
---
app/views/articles/index.html.erb
---
<div class="row">
  <div class="col"></div>
    <div class="col-md-10">

<h1>list of all article</h1>
<p>
  <%= link_to 'Create NEW Article', new_article_path, class:'btn btn-lg btn-info' %>
</p>
  <table class="table table-hover table-striped table-responsive-xs table-danger">
<thead>
    <tr>
      <th>title</th>
      <th>text</th>
      <th colspan="3">Editing option</th>
    <tr>
</thead>
  <% @article.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= truncate(article.text, length: 75) %></td>
      <td><%= link_to 'show', article_path(article), class:'btn btn-sm btn-info' %></td>
      <td><%= link_to 'edit', edit_article_path(article), class:'btn btn-sm btn-warning' %></td>
      <td><%= link_to 'Delete',article_path(article),
               method: :delete,
               data: { confirm: 'Are you sure?' } ,class:'btn btn-sm btn-danger'%>
       </td>
    </tr>
    <% end %>
</table>

<p>
<%= link_to 'home', welcome_index_path, class:'btn btn-sm btn-primary' %>
<%= link_to 'new', new_article_path %>
</p>

</div><!-- col-md-10 -->
 <div class="col"></div>
</div><!-- row -->
---
app/views/articles/show.html.erb
---
<div class="row">
  <div class="col"></div>
    <div class="col-md-7">
<%= image_tag 'YAN-JIANG.jpg', style:"width:100%" %>
<p>
  <h2>TITLE</h2>
  <strong><%= @article.title %></strong>
</p>
<p>
    <%= @article.created_at.strftime('%A %-b %-d, %Y | %l.%M %p') %>
</p>

<p>
  <h3>ARTICLE</h3>
    <%= @article.text %>
</p>

<hr>
<%= render 'comments/comment' %>
<hr>
<%= render 'comments/form' %>


<p>
<%= link_to 'Back', articles_path, class:'btn btn-md btn-info' %>
<%= link_to 'Home', welcome_index_path, class:'btn btn-md btn-primary' %>
</p>

</div><!-- col-md-7 -->
 <div class="col"></div>
</div><!-- row -->
```
```
app/assets/stylesheets/welcome.scss
---
.btn-welcome
{
  background-color: #f31346;
  color: #efeeef
}

.btn-welcome.hover
{
  background-color: #ff2578;
  color: #ffffff;
}

h1
{
  margin-bottom: 20px;
}
---
app/assets/stylesheets/application.scss
---
body {
  min-height: 75rem;
  padding-top: 4.5rem;
  background-color: #ffddee;
}

.container
{
  padding-top:15px;
}


thead
{
  background-color: #553344;
  color: #ffffff;
}

.form-control
{
  background-color: #efeeef;
  border: 3px solid #f3b1c8;
}

.btn-light
{
border: 3px solid #f3b1c8;
}

.jumbotron
{
  background-color: #ffffff;
}
```
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq5fw6abxmj31kw0s7trk.jpg)
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq5fvv9543j31kw0mvn10.jpg)
![image](https://ws3.sinaimg.cn/large/006tKfTcgy1fq5fvja1hyj31kw0vakb9.jpg)

```
git checkout -b layout-scss
git add .
git commit -m "added layout-scss"
git push origin layout-scss
```
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq5fz68bapj31b20jsdl7.jpg)

bootstarap 4
build custom footer
closer look at column division
modify column properties
style the footer

```
git checkout -b footer
app/views/shared/_footer.html.erb
---
<section class="foot" >
  <div class="row" style="padding-top:8%;">
    <div class="col-md-4 darker">
      <div class="col-md-12 padding white">
        <h4>general info</h4>
        <hr>
        <h5 class="linktxt">address line 1</h5>
        <h5 class="linktxt">address line 2</h5>
        <h5 class="linktxt">address line 3</h5>
        <hr>
        <p class="small-font grey">&copy; superxschool.com 2017 all rigths reserved</p>
      </div>
    </div> <!-- col-md-4 -->

    <div class="col-md-4">
      <div class="col-md-12 padding white">
        <h4>subscribe</h4>
        <hr>
        <form class="form-inline mt-2 mt-md-0">
          <input class="form-control mr-sm-2"
                 type="text"
                 placeholder="input your email" aria-label="email"
                 style="margin-buttom:10px; width:100%;"><br>
          <button class="btn btn-ligth my-2 my-sm-0" type="submit">Submit</button>
        </form>
      </div>
    </div><!-- col-md-4 -->

    <div class="col-md-4 dark">
      <div class="col-md-12 padding white">
        <h4>social</h4>
        <hr>
        <h5><%= link_to 'facebook',welcome_index_path, class:"inktxt" %></h5>
        <h5>twitter</h5>
        <h5>youtube</h5>
      </div>
    </div><!-- col-md-4 -->

  </div><!-- row -->
</section>
---
app/views/welcome/index.html.erb
---
<div class="row" style="padding-top:8%;">
  <div class="col"></div>
  <div class="col-md-8 text-center">
    <%= image_tag 'YAN-JIANG.jpg', style:"width:100%" %>
    <div class="jumbotron">


    <h1>欢迎来到才华横溢的世界</h1>
    <p><%= link_to '进入我的世界', articles_path, class: "btn btn-lg btn-welcome" %></p>
      </div><!-- jumbotron -->
    </div><!-- col-md-7 -->
   <div class="col"></div>
</div><!-- row -->
---
app/views/layouts/application.html.erb
---
<!DOCTYPE html>
<html>
  <head>
    <title>Barbieblog</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'shared/navigation'%>
    <div class="container">
    <%= yield %>
    </div>
    <%= render 'shared/footer'%>
  </body>
</html>
---
```
```
app/assets/stylesheets/application.scss
---
@import "bootstrap";
@import "welcome";
@import "navigation";
@import "footer";

body {
  min-height: 50rem;
  padding-top: 4.5rem;
  background-color: #ffddee;
  overflow-x: hidden;
}

.white
{
 color: #ffffff;
}

.grey
{
  color:#ddcccc;
}

.small.font
{
  font-size: 11px;
}
.linktxt
{
  color: #deddee;
}

.linktx:hover
{
  color: #ffffff;
}

.container
{
  padding-top:15px;
}


thead
{
  background-color: #553344;
  color: #ffffff;
}

.form-control
{
  background-color: #efeeef;
  border: 3px solid #f3b1c8;
}

.btn-light
{
border: 3px solid #f3b1c8;
}

.jumbotron
{
  background-color: #ffffff;
}
---
app/assets/stylesheets/footer.scss
---
.footer
{
  background-color: #f31346
  min-height": 10rem;"
  margin-top": 2rem;"
}

.col-md-4
{
  min-width: 10rem;
  padding: 0;
  margin: 0;
}

.padding
{
  padding:2rem;
  padding-bottom: 1rem;
}
---
```
![image](https://ws4.sinaimg.cn/large/006tKfTcgy1fq67i5w2bdj31kw0vce2w.jpg)
![image](https://ws1.sinaimg.cn/large/006tKfTcgy1fq67hx1btkj31kw0okn0y.jpg)
```
git add .
git commit -m "add styled bootstrap:home page,table,image,links,navigation,and footer."
git push origin footer
```

helper methods
adding a custom helper methods
calling the helper from navigation
understanding passing of arguments

# SECTION 12
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org

```
git checkout -b helper-methods
---
app/helpers/application_helper.rb
---
module ApplicationHelper

  # if on active page color = white
  # if not on active page color = require
  # take arguments: 'link','what page its on','url''change font color'

  def active_link_to(nav_link, contrl, action, url, style)
    if controller_name == contrl && action_name == action
      return link_to nav_link, url, id: style
    else
      return link_to nav_link, url, class: style
    end
  end
end
---
app/views/shared/_navigation.html.erb
---
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="#">xiaoweiblog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <!-- nav_link, action, url, style -->
      <%= active_link_to 'Home','welcome','index',welcome_index_path, 'active_nav-link' %>
      </li>
      <li class="nav-item">
        <%= active_link_to 'Blog', 'articles','index', articles_path, 'active_nav-link' %>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">About</a>
      </li>
    </ul>
    <form class="form-inline mt-2 mt-md-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
      <button class="btn btn-ligth my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
---
app/assets/stylesheets/navigation.scss
---
.navbar
{
  background-color: #f31346 !important;
}

.nav-link
{}

#active_nav-link
{
  display: block;
  padding: 0.5rem 1rem;
  color: #ffffff !important;
}

.active_nav-link
{
  display: block;
  padding: 0.5rem 1rem;
  color: #f3cace !important;
}


.nav-item a
{
  font-weight: bold;
  color: #f3cace !important;
}

.nav-item a:hover
{
  font-weight: bold;
  color: #ffffff;
}

.navbar-toggler
{
  border: 2px solid #ffffff !important;
}
---
```
![image](https://ws4.sinaimg.cn/large/006tKfTcgy1fq6gmtawhmj31kw0thqq5.jpg)

```
git status
git add .
git commit -m "added a custom helper method for
active links in navigation bar"
git push origin helper-methods
```

working search form
edit routes file
create a method in a article model file
add a search action in articles controller
add a correspondig search view file
some errors

# SECTION 13
GETTING STARTED WITH RAILS
based on guides.rubyonrails.org
```
git checkout -b search
---
config/routes.rb
---
Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  resources :articles do
    resources :comments
     collection do
      get :search # creates a new path for the searching
    end
  end
end
---
app/models/article.rb
---
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
              length: {minimum: 3}
  validates :text, presence: true,
              length: {minimum: 2}

   def self.search(params)
   articles = Article.where("text LIKE ? or title LIKE ?", "%#{params[:search]}%",
             "%#{params[:search]}%") if params[:search].present?
   articles # returns the articles containing the search words
 end
end
---
---
app/views/shared/_navigation.html.erb
---
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="#">xiaoweiblog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <!-- nav_link, action, url, style -->
      <%= active_link_to 'Home','welcome','index',welcome_index_path, 'active_nav-link' %>
      </li>
      <li class="nav-item">
        <%= active_link_to 'Blog', 'articles','index', articles_path, 'active_nav-link' %>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">About</a>
      </li>
    </ul>
    <div class="form-inline mt-2 mt-md-0">
      <%= form_tag search_articles_path, method: :get do %>
      <%= text_field_tag :search, nil, placeholder: "Search", class: "form-control mr-sm-2" %>
      <%= submit_tag "Search", class: "btn btn-ligth my-2 my-sm-0" %>
    <% end %>
    </div>

  <!--  <form class="form-inline mt-2 mt-md-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
      <button class="btn btn-ligth my-2 my-sm-0" type="submit">Search</button>
    </form>
  -->
  </div>
</nav>
---
app/controllers/articles_controller.rb
---
class ArticlesController < ApplicationController
http_basic_authenticate_with name: "xiaowei", password: "123456",
except: [:index, :show, :search]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
      @article = Article.find(params[:id])
  end


  def search
    if params[:search].blank?
      @articles = Article.all
    else
      @articles = Article.search(params)
    end
  end


  def update
      @article = Article.find(params[:id])
      if @article.update(article_params)
         redirect_to @article
      else
        render 'edit'
    end
  end



  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
    redirect_to @article
   else
    render 'new'
   end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end

  end
---
app/views/articles/search.html.erb
<div class="row">
  <div class="col"></div>
    <div class="col-md-10">

<h1>list of articles matching  your search world</h1>

  <table class="table table-hover table-striped table-responsive-xs table-danger">
<thead>
    <tr>
      <th>title</th>
      <th>text</th>
      <th colspan="3">Editing option</th>
    <tr>
</thead>
  <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= truncate(article.text, length: 75) %></td>
      <td><%= link_to 'show', article_path(article), class:'btn btn-sm btn-info' %></td>
      <td><%= link_to 'edit', edit_article_path(article), class:'btn btn-sm btn-warning' %></td>
      <td><%= link_to 'Delete',article_path(article),
               method: :delete,
               data: { confirm: 'Are you sure?' } ,class:'btn btn-sm btn-danger'%>
       </td>
    </tr>
    <% end %>
</table>

<p>
<%= link_to 'back to all article', articles_path, class:'btn btn-sm btn-primary' %>
</p>

</div><!-- col-md-10 -->
 <div class="col"></div>
</div><!-- row -->
---
```
![image](https://ws4.sinaimg.cn/large/006tKfTcgy1fq7lq236pkj31kw0q2jvg.jpg)
![image](https://ws3.sinaimg.cn/large/006tKfTcgy1fq7lqhervnj31kw0gggoj.jpg)
![image](https://ws2.sinaimg.cn/large/006tKfTcgy1fq7lqa7pu3j31kw0cj0up.jpg)
```
git status
git add .
git commit -m "created a working search button"
git push origin search
```
