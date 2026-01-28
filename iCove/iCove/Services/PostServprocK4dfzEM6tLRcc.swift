//
//  PostServK4dfzEM6tLRcc.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

protocol PostServprocK4dfzEM6tLRcc {
  func lop2a7747mqGbbAJ() -> [Post]
  func locolpyNmAmeqnsrIBw(by kgGciVztxAZqS: [String]) -> [Post]
  func gepoidnrfBTqdPsaCHv(_ KATsvO6TAGsPN: String) -> Post?
  func updKy5KTuspwUdal(_ p7lcZuVKGhfFFs: Post)
  func addHqRpcCjOX2uuE(_ gwp32paANQmAr: Post)
  func delNgIsy6xdaSP92(_ uidh88nMhcK8IH3Z: String) -> [String]
}

class PostServK4dfzEM6tLRcc: PostServprocK4dfzEM6tLRcc {
  static let shared = PostServK4dfzEM6tLRcc()

  private let pkeyX1xbfjmAvm5si = "u1Bn56sOg2fuG"

  private let smp8MDGURI7EBZK8: [Post] = [
    Post(
      id: "post_001",
      iT1uV3wX5yZ7aB: [
        "qC2VdAxOOOikJD6i11",
        "qC2VdAxOOOikJD6i12",
        "qC2VdAxOOOikJD6i13",
      ],
      aC9dE1fG3hI5jK: "user_002",
      cL7mN9oP1qR3sT:
        "Today, I wore a red sweater and a floral skirt, and added some delicate touches with pearl earrings.",
      tK3lM5nO7pQ9rS: Date().addingTimeInterval(-3600)
    ),
    Post(
      id: "post_002",
      iT1uV3wX5yZ7aB: [
        "qC2VdAxOOOikJD6i21",
        "qC2VdAxOOOikJD6i22",
        "qC2VdAxOOOikJD6i23",
        "qC2VdAxOOOikJD6i24",
      ],
      aC9dE1fG3hI5jK: "user_003",
      cL7mN9oP1qR3sT:
        "Who knows? Recently, I've been super into the green color scheme. Whether it's dark green or light green, it always looks super textured when worn.",
      tK3lM5nO7pQ9rS: Date().addingTimeInterval(-7200)
    ),
    Post(
      id: "post_003",
      iT1uV3wX5yZ7aB: [
        "qC2VdAxOOOikJD6i31",
        "qC2VdAxOOOikJD6i32",
        "qC2VdAxOOOikJD6i33",
        "qC2VdAxOOOikJD6i34",
        "qC2VdAxOOOikJD6i35",
      ],
      aC9dE1fG3hI5jK: "user_004",
      cL7mN9oP1qR3sT:
        "The main focus is on comfort. Simple combination, neat and tidy.",
      tK3lM5nO7pQ9rS: Date().addingTimeInterval(-14400)
    ),
  ]

  private init() {
    if lop2a7747mqGbbAJ().isEmpty {
      initbP5TFVFch1xuZ()
    }
  }

  // MARK: - Public Methods

  func lop2a7747mqGbbAJ() -> [Post] {
    guard let aoV356TuRO6NI = UserDefaults.standard.data(forKey: pkeyX1xbfjmAvm5si),
      let p641SZL5HA0Fsc = try? JSONDecoder().decode([Post].self, from: aoV356TuRO6NI)
    else {
      return []
    }
    return p641SZL5HA0Fsc
  }

  func sI73Ybh2Vhn2zM(_ p641SZL5HA0Fsc: [Post]) {
    if let BNUs95loGP5jS = try? JSONEncoder().encode(p641SZL5HA0Fsc) {
      UserDefaults.standard.set(BNUs95loGP5jS, forKey: pkeyX1xbfjmAvm5si)
    }
  }

  func locolpyNmAmeqnsrIBw(by kgGciVztxAZqS: [String]) -> [Post] {
    let BNUs95loGP5jS = lop2a7747mqGbbAJ()
    return BNUs95loGP5jS.filter { kgGciVztxAZqS.contains($0.id) }
  }

  func gepoidnrfBTqdPsaCHv(_ KATsvO6TAGsPN: String) -> Post? {
    let BNUs95loGP5jS = lop2a7747mqGbbAJ()
    return BNUs95loGP5jS.first(where: { $0.id == KATsvO6TAGsPN })
  }

  func updKy5KTuspwUdal(_ p7lcZuVKGhfFFs: Post) {
    var JUQ8d5qdvZSjJ = lop2a7747mqGbbAJ()
    if let index = JUQ8d5qdvZSjJ.firstIndex(where: { $0.id == p7lcZuVKGhfFFs.id }) {
      JUQ8d5qdvZSjJ[index] = p7lcZuVKGhfFFs
      sI73Ybh2Vhn2zM(JUQ8d5qdvZSjJ)
    }
  }

  func addHqRpcCjOX2uuE(_ p7lcZuVKGhfFFs: Post) {
    var JUQ8d5qdvZSjJ = lop2a7747mqGbbAJ()
    JUQ8d5qdvZSjJ.insert(p7lcZuVKGhfFFs, at: 0)
    sI73Ybh2Vhn2zM(JUQ8d5qdvZSjJ)
  }

  func delNgIsy6xdaSP92(_ uidh88nMhcK8IH3Z: String) -> [String] {
    let JUQ8d5qdvZSjJ = lop2a7747mqGbbAJ()
    let o7dgQ5ecnCmHN = JUQ8d5qdvZSjJ.filter { $0.aC9dE1fG3hI5jK == uidh88nMhcK8IH3Z }
    let r2FrvQFwJDtSOK = o7dgQ5ecnCmHN.map(\.id)
    let khERrUUEo5P4H = JUQ8d5qdvZSjJ.filter { $0.aC9dE1fG3hI5jK != uidh88nMhcK8IH3Z }
    sI73Ybh2Vhn2zM(khERrUUEo5P4H)
    return r2FrvQFwJDtSOK
  }

  private func initbP5TFVFch1xuZ() {
    sI73Ybh2Vhn2zM(smp8MDGURI7EBZK8)
  }
}
