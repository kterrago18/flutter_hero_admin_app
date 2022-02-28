import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCredentials {
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqZWdyamhrYXVvb2R5emRleXBuIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDQ3MTAyMTgsImV4cCI6MTk2MDI4NjIxOH0.hzZAS5J8x33Tg76uEu882AiLJxQqGJEy1CggVufeUfw';
  static const String apiUrl = 'https://qjegrjhkauoodyzdeypn.supabase.co';

  static SupabaseClient supabaseClient = SupabaseClient(apiUrl, apiKey);
}
