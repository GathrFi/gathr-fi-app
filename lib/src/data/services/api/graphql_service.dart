import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  GraphQLService(this.client);
  final GraphQLClient client;

  Future<QueryResult> query(String document, Map<String, dynamic> variables) {
    return client.query(
      QueryOptions(
        document: gql(document),
        variables: variables,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
  }

  Future<QueryResult> mutate(String document, Map<String, dynamic> variables) {
    return client.mutate(
      MutationOptions(
        document: gql(document),
        variables: variables,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
  }
}
