//
//  Authentication.swift
//  Liftoff
//
//  Created by Gavin Gichini on 3/1/25.
//

import Foundation
import Supabase

/// A ckass that manages authentication state.
@Observable public class Authentication {

    let client = SupabaseClient(
        supabaseURL: URL(string: "https://ojzqniqmtixqrqexqfpq.supabase.co")!,
        supabaseKey:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qenFuaXFtdGl4cXJxZXhxZnBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA4NTA4NzQsImV4cCI6MjA1NjQyNjg3NH0.K21-zwjQW6D6nUTxWxCxmgjh-YP9SIOuksh_DnhPBA4"
    )

}
