const String getLinksQuery = """
query getLink{
  links{
    id
    name 
    description
    image
    postedBy{
      username
    }
    votes{
      id
    }
  }
}
""";

const String createUserMutation = """
mutation createUser(\$email: String!, \$password: String!, \$username: String!){
  createUser(email: \$email, password: \$password, username: \$username){
    user{
      email
      username
      password
    }
  }
}
""";

const String createLinkMutation = """
mutation createLink(\$name: String!, \$description: String!, \$image: String!){
  createLink(name: \$name, description: \$description, image: \$image) {
    id
    description
    image
    name
  }
}
""";

const String tokenAuthMutation = """
mutation tokenAuth(\$username: String!, \$password: String!){
  tokenAuth(username: \$username, password: \$password){
    token
  }
}
""";

const String createVoteMutation = """
mutation createVote(\$linkId: Int!){
  createVote(linkId: \$linkId){
    user{
      username
    }
  }
}
""";
