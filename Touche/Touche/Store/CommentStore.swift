//
//  CommentStore.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import Foundation
import FirebaseFirestore

class CommentStore: ObservableObject {
    @Published var commentStore: [Comment] = []
    var perfumeID: String = ""
    let database = Firestore.firestore().collection("Perfume")
    
    func fetchComment() {
        database.document(perfumeID).collection("comments").getDocuments { (snapshot, error) in
            self.commentStore.removeAll()
            if let snapshot {
                for document in snapshot.documents{
                    let docData = document.data()
                    let id = document.documentID
                    let contents: String = docData["contents"] as? String ?? ""
                    let createdAt: String = docData["createdAt"] as? String ?? ""
                    let nickName: String = docData["nickName"] as? String ?? ""
                    let writerUID: String = docData["writerUID"] as? String ?? ""
                    
                    let comment: Comment = Comment(id: id, contents: contents, createdAt: createdAt, nickName: nickName, writerUID: writerUID)
                    self.commentStore.append(comment)
                }
            }
        }
    }
    
    func addComment(comment: Comment) {
        database.document(perfumeID).collection("comments").document(comment.id ?? "")
            .setData([
                "contents": comment.contents ?? "",
                "createdAt": comment.createdAt ?? "",
                "nickName": comment.nickName ?? "",
                "writerUID": comment.writerUID ?? ""])
        fetchComment()
    }
    
    func updateComment(comment: Comment) {
        database.document(perfumeID).collection("comments").document(comment.id ?? "")
            .setData([
                "contents": comment.contents ?? "",
                "createdAt": comment.createdAt ?? "",
                "nickName": comment.nickName ?? "",
                "writerUID": comment.writerUID ?? ""], merge: true)
        fetchComment()
    }
    
    func removeComment(comment: Comment){
        database.document(perfumeID).collection("comments").document(comment.id ?? "")
            .delete()
        fetchComment()
    }
}
