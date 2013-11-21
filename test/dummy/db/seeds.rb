RailsCodebook::Codebook.create(value: "low",name: "cb.low",cb_name: "importances")
RailsCodebook::Codebook.create(value: "medium",name: "cb.medium",cb_name: "importances")
RailsCodebook::Codebook.create(value: "high",name: "cb.high",cb_name: "importances")

RailsCodebook::Codebook.create(value: "concept",name: "cb.concept",cb_name: "statuses")
RailsCodebook::Codebook.create(value: "published",name: "cb.published",cb_name: "statuses")
RailsCodebook::Codebook.create(value: "archived",name: "cb.archived",cb_name: "statuses")

RailsCodebook::Codebook.create(value: "home",name: "cb.home",cb_name: "article_commet_relations_types")
RailsCodebook::Codebook.create(value: "work",name: "cb.work",cb_name: "article_commet_relations_types")
RailsCodebook::Codebook.create(value: "public",name: "cb.public",cb_name: "article_commet_relations_types")

Article.create(
    author: "Yourself",
    title: "Lorem ipsum dolor sit amet",
    text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin mattis lacinia justo. 
            Donec iaculis gravida nulla. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, 
            orci. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id
            quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. 
            Nullam lectus justo, vulputate eget mollis sed, tempor sed magna. Lorem ipsum dolor sit amet, 
            consectetuer adipiscing elit. Donec vitae arcu. Quisque porta. Suspendisse nisl. Etiam ligula pede, 
            sagittis quis, interdum ultricies, scelerisque eu. Praesent vitae arcu tempor neque lacinia pretium. 
            Vestibulum erat nulla, ullamcorper nec, rutrum non, nonummy ac, erat.",
    importance_cb: "low"
  )

Article.create(
    author: "Others",
    title: "Integer in sapien",
    text: "Integer in sapien. Quisque tincidunt scelerisque libero. Nullam eget nisl. Duis condimentum augue id magna 
          semper rutrum. Pellentesque arcu. Nulla turpis magna, cursus sit amet, suscipit a, interdum id, felis. Etiam 
          posuere lacus quis dolor. Vivamus luctus egestas leo. Cum sociis natoque penatibus et magnis dis parturient montes, 
          nascetur ridiculus mus. Mauris dictum facilisis augue. Vivamus porttitor turpis ac leo. Itaque earum rerum hic 
          tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus 
          asperiores repellat. Aenean fermentum risus id tortor. Nulla accumsan, elit sit amet varius semper, nulla mauris 
          mollis quam, tempor suscipit diam nulla vel leo. Maecenas sollicitudin. Et harum quidem rerum facilis est et expedita 
          distinctio. Integer malesuada.",
    importance_cb: "medium"
  )

Article.create(
    author: "Myself",
    title: "Quisque tincidunt scelerisque libero",
    text: "Quisque tincidunt scelerisque libero. Praesent vitae arcu tempor neque lacinia pretium. Nullam faucibus 
          mi quis velit. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut 
          et voluptates repudiandae sint et molestiae non recusandae. In dapibus augue non sapien. Vestibulum erat nulla, 
          ullamcorper nec, rutrum non, nonummy ac, erat. Fusce suscipit libero eget elit. Fusce tellus. Duis pulvinar. 
          Quisque porta. Phasellus rhoncus.",
    importance_cb: "high"
  )

Article.create(
    author: "Somebody",
    title: "Sed ac dolor sit amet purus",
    text: "Sed ac dolor sit amet purus malesuada congue. Nunc auctor. Nulla accumsan, elit sit amet varius semper, 
          nulla mauris mollis quam, tempor suscipit diam nulla vel leo. Proin in tellus sit amet nibh dignissim sagittis. 
          Pellentesque ipsum. Duis pulvinar. Cras pede libero, dapibus nec, pretium sit amet, tempor quis. Nullam justo enim, 
          consectetuer nec, ullamcorper ac, vestibulum in, elit. In convallis. Pellentesque ipsum. Nullam dapibus fermentum 
          ipsum.",
    importance_cb: "low"
  )

Article.create(
    author: "Anybody",
    title: "Neque porro quisquam est",
    text: "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam 
          eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Nullam at arcu a est sollicitudin
           euismod. Nullam lectus justo, vulputate eget mollis sed, tempor sed magna. Integer imperdiet lectus quis justo. 
           Nunc auctor. Duis ante orci, molestie vitae vehicula venenatis, tincidunt ac pede. Vestibulum erat nulla, 
           ullamcorper nec, rutrum non, nonummy ac, erat. In convallis. Nunc dapibus tortor vel mi dapibus sollicitudin. 
           Nullam dapibus fermentum ipsum. Fusce suscipit libero eget elit. Suspendisse nisl.",
    importance_cb: "high"
  )

Comment.create(
    author: "Anybody",
    content: "ullamcorper nec, rutrum non, nonummy ac, erat. In convallis. Nunc dapibus tortor vel mi dapibus sollicitudin. ",
    type_cb: "published"
  )
Comment.create(
    author: "Nobody",
    content: "Nunc auctor. Duis ante orci, molestie vitae vehicula venenatis, tincidunt ac pede. Vestibulum erat nulla, ",
    type_cb: "published"
  )
Comment.create(
    author: "Somebody",
    content: "Nullam dapibus fermentum ipsum. Fusce suscipit libero eget elit. Suspendisse nisl.",
    type_cb: "published"
  )
Comment.create(
    author: "Myself",
    content: "mi quis velit. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut ",
    type_cb: "concept"
  )
Comment.create(
    author: "Yourself",
    content: "Integer in sapien. Quisque tincidunt scelerisque libero. Nullam eget nisl. Duis condimentum augue id magna semper ",
    type_cb: "concept"
  )
Comment.create(
    author: "Everybody",
    content: "s augue. Vivamus porttitor turpis ac leo. Itaque earum rerum hic tenetur a sapiente delectus, ut aut ",
    type_cb: "concept"
  )
Comment.create(
    author: "Nobody",
    content: " modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Nullam at arcu a est sollicitudin ",
    type_cb: "concept"
  )
Comment.create(
    author: "Somebody",
    content: "auctor. Duis ante orci, molestie vitae vehicula venenatis, tincidunt ac pede. Vestibulum erat nulla, ullamcorper nec, ",
    type_cb: "archived"
  )
Comment.create(
    author: "Anybody",
    content: "eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Nullam at arcu a est sollicitudin ",
    type_cb: "archived"
  )
Comment.create(
    author: "Noone",
    content: "pulvinar. Cras pede libero, dapibus nec, pretium sit amet, tempor quis. Nullam justo enim, consectetuer nec, ullamcorper ",
    type_cb: "archived"
  )

CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "1",
    comment_id: "1",
    status_cb: "home"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "5",
    comment_id: "2",
    status_cb: "home"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "5",
    comment_id: "3",
    status_cb: "work"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "5",
    comment_id: "4",
    status_cb: "home"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "4",
    comment_id: "5",
    status_cb: "work"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "4",
    comment_id: "6",
    status_cb: "public"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "2",
    comment_id: "7",
    status_cb: "home"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "2",
    comment_id: "8",
    status_cb: "public"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "3",
    comment_id: "9",
    status_cb: "work"
  )
CommentRelations.create(
    commentable_type: "Article",
    commentable_id: "3",
    comment_id: "10",
    status_cb: "work"
  )