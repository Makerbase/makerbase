#MakerBase
----------

[![Build Status](https://travis-ci.org/Makerbase/makerbase.svg?branch=master)](https://travis-ci.org/Makerbase/makerbase)  [![Coverage Status](https://coveralls.io/repos/Makerbase/makerbase/badge.svg?branch=master)](https://coveralls.io/r/Makerbase/makerbase?branch=master)  [![Code Climate](https://codeclimate.com/github/Makerbase/makerbase/badges/gpa.svg)](https://codeclimate.com/github/Makerbase/makerbase)

##[Use MakerBASE on Heroku](http://makerbase.herokuapp.com)

###Index:
---------


###Screenshots:
---------------

SS

###Brief:
---------
To create a tutorial, resource and knowledge sharing website.

###Our Approach:
----------------

We started the conversation with our coaches so we could determine what our goals and MVP were.  Very early on they indicated that the in-house engineering team at [Makers](http://www.makersacademy.com) were intending to do something very similar to this for internal use by students only.  They also indicated some added functionality they wanted to include.

Seeing as they were our client we decided to roll with it.  We brainstormed what we would want out of a site like this and what we, as students ourselves, would have found helpful during our time.

With that we designed a survey that students, past and present, answered to help us slimline our concept and find an MVP.  The top three items were aggregation and rating of resources (internal and external), an avenue to solicit more code reviews, and lastly a [Stack Overflow](http://www.stackoverflow.com)-clone where they could ask for very basic advice safe in the knowledge that they wouldn't get shot down.

#####[Survey Results](https://docs.google.com/forms/d/1_F1q0ns_k1sXZH_N6QzURXs-20X1mr1VLXO5iFzmTmQ/viewanalytics)

Armed with that knowledge we set off with our MVP and bonus features, and wrote our user stories.

workflow
discussion
mvp
interviews
questionnaire
adjustment

###User Stories:
-------------

```
As a Maker who has too many logins to remember
So I can quickly access the site
I want to log in with my Github account

As a Maker who wants a safe environment to communicate in
So I can share and help members of my community
I want the site to require membership of the Makers Academy organization

As a Maker who has found a useful resource  
So I can share that resource  
I want to add a link to it  

As a Maker who is looking for information  
So I can make the best use of my time  
I want to view resources  

As a Maker who posts information  
So I can keep it up to date  
I want to be able to edit my posts  

As a Maker who posts information  
So I can remove outdated content  
I want to be able to delete my posts  

As a Maker  
So I can rate the best resources  
I want to be able to upvote  

As a Maker  
So I can see the most popular resources  
I want to list them by rating  

As a Maker  
So other people can filter by tags  
I want to be able to add tags to my uploads  

As a Maker  
So I can see the list of relevant resources  
I want to be able to filter by tags  

As a Maker  
So I can see resources in my desired order  
I want to be able to sort resources  

As a Maker  
So I can get better at coding  
I want to get more feedback on my code  

As a Maker  
So I can rate the best forum comments  
I want to be able to upvote  

As a Maker  
So I can see the relevant information  
I want to be able to filter by tag  
```

Tests:
------
```
WelcomeController
  GET #index
    returns http success

code review
  no review requests have been added
    should display a button to add a review
  review request has been added
    should display review request
  user submits request for code review
    displays the request
    user can see link to delete code review request
    user can delete request
    another user cannot see delete link
    user can see link to edit code review request
    user can edit request
    another user cannot see edit link
    has URL for repository to be reviewed

comments
  allow users to leave a comment on a post

Forum
  user navigates to Forum page
    when there are no questions
    when there are questions
    questions can be deleted
    questions can be edited
    user answers question

posts
  no posts/resources have been added
    should prompt to add a post
  posts/resources have been added
    display posts
  user adding posts
    user adds a post
    with tags
  deleting post
    removes a post when a user clicks delete button
  editing posts
    let a user edit a restaurant

ratings system (likes and dislikes)
  user rates resource
    likes a resource, which updates like count by one
    user dislikes a resource, which updates dislike count by one
    user dislikes a resource, which he previously liked
    user likes a resource, which he previously disliked
    user dislikes a resource and dislikes again
    user dilikes a resource and redirects to posts_path
    user likes a resource and likes again
    user likes a resource and redirects to posts_path

tagging system
  all tags show up on resources page
  post shows up when selecting a tag

users
  when not signed in
    should see link to sign in
    trying to access code reviews
    trying to create new code review
    redirected to home when trying to access posts page
    redirected to home when trying to access new posts page
    should not see link to Resources
    should not be able to delete resources
    sign in fails if not authenticated
  when signed in
    should see link to resources
    should not see link to sign in
    should see link to sign out
    can sign out
    can go to resources page
    can add a post/resource
    can only edit comments that he created
    can only delete comments that he created
    trying to create new code review - flash message

Users page
  user clicks on Users tab
    user sees list of all users

Codereview
  should belong to user

Comment
  should belong to post
  should belong to user

Dislike
  should belong to post

Like
  should belong to post

Post
  should belong to user
  should have many taggings
  should have many tags through taggings
  should have many likes
  should have many dislikes
  should have many comments

Tag
  should have many posts
  should have many posts through taggings

Tagging
  should belong to post
  should belong to tag

User
  should have many comments
  should have many posts
  should have many likes through posts
  should have many liked_posts

78 examples, 0 failures, 8 pending
```
