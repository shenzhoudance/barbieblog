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
```
git status
git add .
git commit -m "added vaildations to create article"
git push origin comment
