//
//  Authsdmd0VXzbAnDYServ.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

protocol Authsdmd0VXzbAnDYServProc {
  func loginTtLI36OScTp84(e8MRjCPXAu0wXY: String, IRqSrQCED3nMk: String) async throws
    -> AznsY674Pb5bXx
  func registerPAms88DfTLWMl(Lp2UI0faMaN0D: String, IRqSrQCED3nMk: String, DoH2qI10b8Ovo: String)
    async throws
    -> AznsY674Pb5bXx
  func logoutWfSgkdWFVCXy1(tokene7boa6IniylQI: String) async throws
  func quickOomfaPN43DvOC() async throws -> AznsY674Pb5bXx
  func NECwwAXsDrlrV(uid7xnFp9WG31Lwa: String) async throws
  func resetAD5RG71gufWEh(e1NwZPJd8HYCD8: String, LwBDL4g9GeWqW: String) async throws
  func getbyidQwpUuIWnzzs99(_ uid68zYKTSayOuAI: String) -> User?
  func upd39Yrqyc7YxrPf(_ user: User)
}

class Authsdmd0VXzbAnDYServ: Authsdmd0VXzbAnDYServProc {
  static let shared = Authsdmd0VXzbAnDYServ()

  private var usersz9gmucno15OkO: [String: User] = [
    "user_001": User(
      id: "user_001",
      eK8mN2pQ7rT9vW: "icove@gmail.com",
      uX4yZ6aB8cD0eF: "Garrett",
      aG3hI5jK7lM9nO: "eitJTglOzkSfZvNi1",
      bP2qR4sT6uV8wX: 0,
      cP9hI1jK3lM5nO: ["post_001", "post_002", "post_003"],
      bQ7rS9tU1vW3xY: [],
      fZ5aB7cD9eF1gH: ["user_002", "user_003"],
      fI3jK5lM7nO9pQ: ["user_002"]
    ),
    "user_002": User(
      id: "user_002",
      eK8mN2pQ7rT9vW: "",
      uX4yZ6aB8cD0eF: "Nolan",
      aG3hI5jK7lM9nO: "eitJTglOzkSfZvNi2",
      bP2qR4sT6uV8wX: 0,
      fZ5aB7cD9eF1gH: ["user_001"],
      fI3jK5lM7nO9pQ: ["user_001"]
    ),
    "user_003": User(
      id: "user_003",
      eK8mN2pQ7rT9vW: "",
      uX4yZ6aB8cD0eF: "Bishop",
      aG3hI5jK7lM9nO: "eitJTglOzkSfZvNi3",
      bP2qR4sT6uV8wX: 0,
      fI3jK5lM7nO9pQ: ["user_001"]
    ),
    "user_004": User(
      id: "user_004",
      eK8mN2pQ7rT9vW: "",
      uX4yZ6aB8cD0eF: "Ruth",
      aG3hI5jK7lM9nO: "eitJTglOzkSfZvNi4",
      bP2qR4sT6uV8wX: 0
    ),
    "user_005": User(
      id: "user_005",
      eK8mN2pQ7rT9vW: "",
      uX4yZ6aB8cD0eF: "Silvia",
      aG3hI5jK7lM9nO: "eitJTglOzkSfZvNi5",
      bP2qR4sT6uV8wX: 0
    ),
    "user_006": User(
      id: "user_006",
      eK8mN2pQ7rT9vW: "",
      uX4yZ6aB8cD0eF: "Glinda",
      aG3hI5jK7lM9nO: "eitJTglOzkSfZvNi6",
      bP2qR4sT6uV8wX: 0
    ),
  ]

  private var emtoidPYq44PQMLEKsf: [String: String] = [
    "icove@gmail.com": "user_001"
  ]

  private var pwd9k0LaTLq1KeVL: [String: String] = [
    "icove@gmail.com": "123456"
  ]

  private let ukeyJ0bloNXfRrq6d = "8glx9a6fB7vQP"
  private let emukey3uZVm5X5t8bpt = "TTTEeDzU4kcgR"
  private let pwkeyP9DA5MqehlDAS = "FuvmNLEkK1vmr"

  private init() {
    loapergLdvEjGdMz8sh()
  }

  private func loapergLdvEjGdMz8sh() {
    if let gkCbdsyyDyVvF = UserDefaults.standard.data(forKey: ukeyJ0bloNXfRrq6d),
      let bevU0ArSNILtQ = try? JSONSerialization.jsonObject(with: gkCbdsyyDyVvF)
        as? [String: String]
    {
      var l8djH6VoAGbhhB: [String: User] = [:]
      for (key, Ulr1Nphhjl8kE) in bevU0ArSNILtQ {
        if let vBCSEwFyH0DMy = Data(base64Encoded: Ulr1Nphhjl8kE),
          let hUiSjGUzUVCfz = try? JSONDecoder().decode(User.self, from: vBCSEwFyH0DMy)
        {
          l8djH6VoAGbhhB[key] = hUiSjGUzUVCfz
        }
      }
      if !l8djH6VoAGbhhB.isEmpty {
        usersz9gmucno15OkO = l8djH6VoAGbhhB
      } else {
        susPygtm1nqbnczn()
      }
    } else {
      susPygtm1nqbnczn()
    }

    if let eto6ZRJakpRXActC = UserDefaults.standard.data(forKey: emukey3uZVm5X5t8bpt),
      let geynsCxZwufha = try? JSONSerialization.jsonObject(with: eto6ZRJakpRXActC)
        as? [String: String]
    {
      if !geynsCxZwufha.isEmpty {
        emtoidPYq44PQMLEKsf = geynsCxZwufha
      } else {
        seuidQCy323kI4VYic()
      }
    } else {
      seuidQCy323kI4VYic()
    }

    if let dAPlwUdMLbG3o = UserDefaults.standard.data(forKey: pwkeyP9DA5MqehlDAS),
      let u7wu3rrzY7tzA = try? JSONSerialization.jsonObject(with: dAPlwUdMLbG3o)
        as? [String: String]
    {
      if !u7wu3rrzY7tzA.isEmpty {
        pwd9k0LaTLq1KeVL = u7wu3rrzY7tzA
      } else {
        spwdsf6jja6zlH8CLY()
      }
    } else {
      spwdsf6jja6zlH8CLY()
    }
  }

  private func susPygtm1nqbnczn() {
    var bevU0ArSNILtQ: [String: String] = [:]
    for (key, user) in usersz9gmucno15OkO {
      if let vBCSEwFyH0DMy = try? JSONEncoder().encode(user) {
        bevU0ArSNILtQ[key] = vBCSEwFyH0DMy.base64EncodedString()
      }
    }

    if let gkCbdsyyDyVvF = try? JSONSerialization.data(withJSONObject: bevU0ArSNILtQ) {
      UserDefaults.standard.set(gkCbdsyyDyVvF, forKey: ukeyJ0bloNXfRrq6d)
    }
  }

  private func seuidQCy323kI4VYic() {
    if let eto6ZRJakpRXActC = try? JSONSerialization.data(withJSONObject: emtoidPYq44PQMLEKsf) {
      UserDefaults.standard.set(eto6ZRJakpRXActC, forKey: emukey3uZVm5X5t8bpt)
    }
  }

  private func spwdsf6jja6zlH8CLY() {
    if let dAPlwUdMLbG3o = try? JSONSerialization.data(withJSONObject: pwd9k0LaTLq1KeVL) {
      UserDefaults.standard.set(dAPlwUdMLbG3o, forKey: pwkeyP9DA5MqehlDAS)
    }
  }

  func loginTtLI36OScTp84(e8MRjCPXAu0wXY: String, IRqSrQCED3nMk: String) async throws
    -> AznsY674Pb5bXx
  {
    try await Task.sleep(nanoseconds: 1_000_000_000)

    guard isval7z4VcmVmK9Mui(e8MRjCPXAu0wXY) else {
      throw AuthErrorNLkjfmEVO3rVW.U7PdwkbVVPUKx("Incorrect email format.")
    }

    guard IRqSrQCED3nMk.count >= 6 else {
      throw AuthErrorNLkjfmEVO3rVW.vj8Fe0ftzWxwW("The password must be at least 6 characters long.")
    }

    let uayE3XhyLo5Xv = e8MRjCPXAu0wXY.lowercased()
    guard let WFgvhOOYHIcWq = emtoidPYq44PQMLEKsf[uayE3XhyLo5Xv],
      let iGudaBL9xeDxn = usersz9gmucno15OkO[WFgvhOOYHIcWq]
    else {
      throw AuthErrorNLkjfmEVO3rVW.v4nww3wWciJDkm("User does not exist.")
    }

    guard pwd9k0LaTLq1KeVL[uayE3XhyLo5Xv] == IRqSrQCED3nMk else {
      throw AuthErrorNLkjfmEVO3rVW.eFQHXvLi7fsCP("Incorrect email or password.")
    }

    let ZPBhIt8BW82kN = gentokLhDabp3qvYWS0(for: iGudaBL9xeDxn.id)

    return AznsY674Pb5bXx(
      xvoSkiukR4DXftoken: ZPBhIt8BW82kN,
      userVMVsqf1elekSw: iGudaBL9xeDxn
    )
  }

  func registerPAms88DfTLWMl(Lp2UI0faMaN0D: String, IRqSrQCED3nMk: String, DoH2qI10b8Ovo: String)
    async throws
    -> AznsY674Pb5bXx
  {
    try await Task.sleep(nanoseconds: 1_000_000_000)

    guard isval7z4VcmVmK9Mui(Lp2UI0faMaN0D) else {
      throw AuthErrorNLkjfmEVO3rVW.U7PdwkbVVPUKx("Incorrect email format.")
    }

    guard IRqSrQCED3nMk.count >= 6 else {
      throw AuthErrorNLkjfmEVO3rVW.vj8Fe0ftzWxwW("The password must be at least 6 characters long.")
    }

    guard DoH2qI10b8Ovo.count >= 2 && DoH2qI10b8Ovo.count <= 20 else {
      throw AuthErrorNLkjfmEVO3rVW.EIC6Ls6G3rvp3("The username must be between 2 and 20 characters long.")
    }

    let uayE3XhyLo5Xv = Lp2UI0faMaN0D.lowercased()
    if emtoidPYq44PQMLEKsf[uayE3XhyLo5Xv] != nil {
      throw AuthErrorNLkjfmEVO3rVW.PSZGWN9sdlSYp("The email has already been registered.")
    }

    let WFgvhOOYHIcWq = "user_\(UUID().uuidString.prefix(8))"
    let XTmHns6NRlpLB = User(
      id: WFgvhOOYHIcWq,
      eK8mN2pQ7rT9vW: uayE3XhyLo5Xv,
      uX4yZ6aB8cD0eF: DoH2qI10b8Ovo,
      aG3hI5jK7lM9nO: "icove_logo",
      bP2qR4sT6uV8wX: 0
    )
    usersz9gmucno15OkO[WFgvhOOYHIcWq] = XTmHns6NRlpLB
    emtoidPYq44PQMLEKsf[uayE3XhyLo5Xv] = WFgvhOOYHIcWq
    pwd9k0LaTLq1KeVL[uayE3XhyLo5Xv] = IRqSrQCED3nMk

    susPygtm1nqbnczn()
    seuidQCy323kI4VYic()
    spwdsf6jja6zlH8CLY()

    let V4N1fnHmbn0X8 = gentokLhDabp3qvYWS0(for: WFgvhOOYHIcWq)

    return AznsY674Pb5bXx(
      xvoSkiukR4DXftoken: V4N1fnHmbn0X8,
      userVMVsqf1elekSw: XTmHns6NRlpLB
    )
  }

  func logoutWfSgkdWFVCXy1(tokene7boa6IniylQI: String) async throws {
    try await Task.sleep(nanoseconds: 300_000_000)
  }

  func quickOomfaPN43DvOC() async throws -> AznsY674Pb5bXx {
    try await Task.sleep(nanoseconds: 1_000_000_000)

    if let q4u1IUczwDGh1q = getq9PrlZ8SdrKEmA() {
      let l9x6CGj2k6c33 = gentokLhDabp3qvYWS0(for: q4u1IUczwDGh1q.id)
      return AznsY674Pb5bXx(
        xvoSkiukR4DXftoken: l9x6CGj2k6c33,
        userVMVsqf1elekSw: q4u1IUczwDGh1q
      )
    } else {
      let WFgvhOOYHIcWq = "quick_\(UUID().uuidString.prefix(8))"
      let mgpmQnAUc7BNX = "quick_\(UUID().uuidString.prefix(8))@quicklogin.local"
      let una5AuuJVrC7nWRk = "Quick\(Int.random(in: 1000...9999))"
      let hOPiKIqV7NbdY = UUID().uuidString

      let XTmHns6NRlpLB = User(
        id: WFgvhOOYHIcWq,
        eK8mN2pQ7rT9vW: mgpmQnAUc7BNX,
        uX4yZ6aB8cD0eF: una5AuuJVrC7nWRk,
        aG3hI5jK7lM9nO: "icove_logo",
        bP2qR4sT6uV8wX: 0
      )

      usersz9gmucno15OkO[WFgvhOOYHIcWq] = XTmHns6NRlpLB
      emtoidPYq44PQMLEKsf[mgpmQnAUc7BNX] = WFgvhOOYHIcWq
      pwd9k0LaTLq1KeVL[mgpmQnAUc7BNX] = hOPiKIqV7NbdY

      susPygtm1nqbnczn()
      seuidQCy323kI4VYic()
      spwdsf6jja6zlH8CLY()
      sqj68L09EvBJjUn(XTmHns6NRlpLB)

      let GNXXGSqOJGx3J = gentokLhDabp3qvYWS0(for: WFgvhOOYHIcWq)

      return AznsY674Pb5bXx(
        xvoSkiukR4DXftoken: GNXXGSqOJGx3J,
        userVMVsqf1elekSw: XTmHns6NRlpLB
      )
    }
  }

  func NECwwAXsDrlrV(uid7xnFp9WG31Lwa: String) async throws {
    try await Task.sleep(nanoseconds: 500_000_000)

    let BOfzdMCb6Hnv2 = VdoServ63WnoDbxzFob0.shared
    let rdFIWbniJo8Cn = ComNAQ136mFLYkZJServ.shared
    let o3Z4kwdgN8kfw = PostServK4dfzEM6tLRcc.shared
    let Vnp3TOMMzEiD5 = ConvsalHLauR9oVrqseServ.shared
    let mnbUQ79Kx8XvH = MsgServyrV03Y9KZYZNL.shared

    let oFimSnnr4TeSy = BOfzdMCb6Hnv2.loc5f3UJvuhXYjoD()
    let fdTC8GdRJIu8v = oFimSnnr4TeSy.filter { $0.aC9dE1fG3hI5jK == uid7xnFp9WG31Lwa }.map(\.id)
    let GDtCweRwLzpFf = oFimSnnr4TeSy.filter { $0.aC9dE1fG3hI5jK != uid7xnFp9WG31Lwa }
    BOfzdMCb6Hnv2.svSqlFE3ULuRtoH(GDtCweRwLzpFf)

    for Scf3crrJa8FVY in fdTC8GdRJIu8v {
      rdFIWbniJo8Cn.delol3Fbm3GLCqns(for: Scf3crrJa8FVY)
    }
    let TFtXfRpVBlub6 = Set(GDtCweRwLzpFf.map(\.id))
    for Scf3crrJa8FVY in TFtXfRpVBlub6 {
      let wOx2KSJCBqX7Q = rdFIWbniJo8Cn.locom1GrYz4YRiuJOq(for: Scf3crrJa8FVY)
      let F5TSilKRGmwHy = wOx2KSJCBqX7Q.filter { $0.aC9dE1fG3hI5jK != uid7xnFp9WG31Lwa }
      if F5TSilKRGmwHy.count != wOx2KSJCBqX7Q.count {
        rdFIWbniJo8Cn.savesDxbX9dKjG5V(for: Scf3crrJa8FVY, a3vNkVhmvsEDE: F5TSilKRGmwHy)
      }
    }

    let Yze17msQEx71t = o3Z4kwdgN8kfw.delNgIsy6xdaSP92(uid7xnFp9WG31Lwa)

    let QWqBIGB9ZGGcw = Vnp3TOMMzEiD5.lovsNlpHQLpsFndh7()
    let LqMzsu0nzvuqX = QWqBIGB9ZGGcw.filter {
      $0.pA5rT1iC3iP5aN7t.contains(uid7xnFp9WG31Lwa)
    }
    for conv in LqMzsu0nzvuqX {
      mnbUQ79Kx8XvH.delfoiaBI3wrW9DqTE(conv.id)
      Vnp3TOMMzEiD5.delcvsQHjORznHQ9t0g(conv.id)
    }

    for (uid, var u) in usersz9gmucno15OkO where uid != uid7xnFp9WG31Lwa {
      u.fZ5aB7cD9eF1gH.removeAll { $0 == uid7xnFp9WG31Lwa }
      u.fI3jK5lM7nO9pQ.removeAll { $0 == uid7xnFp9WG31Lwa }
      u.bQ7rS9tU1vW3xY.removeAll { $0 == uid7xnFp9WG31Lwa }
      u.cP9hI1jK3lM5nO.removeAll { Yze17msQEx71t.contains($0) }
      usersz9gmucno15OkO[uid] = u
    }

    if let u3SQIdmrJzowRu = usersz9gmucno15OkO[uid7xnFp9WG31Lwa] {
      usersz9gmucno15OkO.removeValue(forKey: uid7xnFp9WG31Lwa)
      if !u3SQIdmrJzowRu.eK8mN2pQ7rT9vW.isEmpty {
        emtoidPYq44PQMLEKsf.removeValue(forKey: u3SQIdmrJzowRu.eK8mN2pQ7rT9vW)
        pwd9k0LaTLq1KeVL.removeValue(forKey: u3SQIdmrJzowRu.eK8mN2pQ7rT9vW)
      }
      susPygtm1nqbnczn()
      seuidQCy323kI4VYic()
      spwdsf6jja6zlH8CLY()
    }

    if let q4u1IUczwDGh1q = getq9PrlZ8SdrKEmA(), q4u1IUczwDGh1q.id == uid7xnFp9WG31Lwa {
      clearnjYxaalAVSaT3()
    }
  }

  private func sqj68L09EvBJjUn(_ xIPdmqzAkFISC: User) {
    if let WyLgpqJpntdth = try? JSONEncoder().encode(xIPdmqzAkFISC) {
      UserDefaults.standard.set(WyLgpqJpntdth, forKey: "quick_login_user")
    }
  }

  private func getq9PrlZ8SdrKEmA() -> User? {
    guard let WyLgpqJpntdth = UserDefaults.standard.data(forKey: "quick_login_user"),
      let xIPdmqzAkFISC = try? JSONDecoder().decode(User.self, from: WyLgpqJpntdth)
    else {
      return nil
    }

    return usersz9gmucno15OkO[xIPdmqzAkFISC.id]
  }

  private func clearnjYxaalAVSaT3() {
    UserDefaults.standard.removeObject(forKey: "quick_login_user")
  }

  func resetAD5RG71gufWEh(e1NwZPJd8HYCD8: String, LwBDL4g9GeWqW: String) async throws {
    try await Task.sleep(nanoseconds: 1_500_000_000)

    guard isval7z4VcmVmK9Mui(e1NwZPJd8HYCD8) else {
      throw AuthErrorNLkjfmEVO3rVW.U7PdwkbVVPUKx("Incorrect email format.")
    }

    guard LwBDL4g9GeWqW.count >= 6 else {
      throw AuthErrorNLkjfmEVO3rVW.vj8Fe0ftzWxwW("The password must be at least 6 characters long.")
    }

    let uayE3XhyLo5Xv = e1NwZPJd8HYCD8.lowercased()
    guard emtoidPYq44PQMLEKsf[uayE3XhyLo5Xv] != nil else {
      throw AuthErrorNLkjfmEVO3rVW.v4nww3wWciJDkm("User does not exist.")
    }

    pwd9k0LaTLq1KeVL[uayE3XhyLo5Xv] = LwBDL4g9GeWqW
    spwdsf6jja6zlH8CLY()

    if let q4u1IUczwDGh1q = getq9PrlZ8SdrKEmA(),
      q4u1IUczwDGh1q.eK8mN2pQ7rT9vW == uayE3XhyLo5Xv
    {
      sqj68L09EvBJjUn(q4u1IUczwDGh1q)
    }
  }

  func getbyidQwpUuIWnzzs99(_ uid68zYKTSayOuAI: String) -> User? {
    return usersz9gmucno15OkO[uid68zYKTSayOuAI]
  }

  func upd39Yrqyc7YxrPf(_ K1d9gSwQ15wja: User) {
    usersz9gmucno15OkO[K1d9gSwQ15wja.id] = K1d9gSwQ15wja
    susPygtm1nqbnczn()

    if let q4u1IUczwDGh1q = getq9PrlZ8SdrKEmA(),
      q4u1IUczwDGh1q.id == K1d9gSwQ15wja.id
    {
      sqj68L09EvBJjUn(K1d9gSwQ15wja)
    }
  }

  private func isval7z4VcmVmK9Mui(_ e982waVABsGCFK: String) -> Bool {
    let sUY1jSSDiA6aG = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let yQmNbDe2oRZhC = NSPredicate(format: "SELF MATCHES %@", sUY1jSSDiA6aG)
    return yQmNbDe2oRZhC.evaluate(with: e982waVABsGCFK)
  }

  private func gentokLhDabp3qvYWS0(for WFgvhOOYHIcWq: String) -> String {
    return "token_\(WFgvhOOYHIcWq)_\(UUID().uuidString.prefix(16))"
  }
}
