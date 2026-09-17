# 本地 Lean 到孙宇晨奖提交 SOP

账号：**CHENLexiao8848**。本例：**JSP-000637 / Erdős 777**。采用“登记完整证明并明确归属”；本次移植和复现不构成首次形式化主张。

## 1. 规则与贡献

已核对官方 commit `82be4c4913b8fe394d68d1391f4c221fde947211` 的 [CONTRIBUTING](https://github.com/TheJustinSunPrize/awards/blob/82be4c4913b8fe394d68d1391f4c221fde947211/CONTRIBUTING.md)、[PR 模板](https://github.com/TheJustinSunPrize/awards/blob/82be4c4913b8fe394d68d1391f4c221fde947211/.github/PULL_REQUEST_TEMPLATE.md)、[归属规范](https://github.com/TheJustinSunPrize/awards/blob/82be4c4913b8fe394d68d1391f4c221fde947211/problems/README.md#attribution-conventions)。每次新提交前重新核对。

- 只接受原始问题全部范围的完整数学解答／Lean 证明；不能含 `sorry`、`admit` 或替代缺失证明的假设。
- 独立公开仓库存证明；官方 awards 只接收引用及题库文字，不上传 Lean、项目配置、依赖、ZIP、二进制。
- 必须提供 repository、branch、完整 40 位 commit SHA、确切 theorem/file、构建步骤、归属证据；branch 必须包含该 commit。
- 数学作者、形式化作者、移植／复现提交者分别记录。PR 作者不自动成为数学作者。
- 当前公开规则未确认旧材料的固定 70/30 分配和严格时间优先条款，不据此承诺奖金。

637 已有 plby 完整证明和 [Issue #19](https://github.com/TheJustinSunPrize/awards/issues/19)。本次新增工作是 v4.34 兼容修复、显式入口、复现与记录。

## 2. 本地完成与验证

核对精确量词、全部三问、定义、版权和依赖后运行：

```powershell
./scripts/verify.ps1 -FetchCache
```

要求构建、五个目标声明公理审计、两个模块逐一 kernel replay 实际成功。允许公理仅 `propext`、`Classical.choice`、`Quot.sound`。失败停止发布；源文件变更后重新验证。打包只能使用与当前 hash 对应的真实成功记录。

## 3. 公开证明仓库

仓库：[CHENLexiao8848/jsp-000637-lean](https://github.com/CHENLexiao8848/jsp-000637-lean)，分支 `main`。公开完整证明、固定 manifest、英文 README、归属／许可证、验证脚本及日志。

检查暂存 diff 和历史，不上传本机路径、接管笔记、凭据、证件或付款信息。提交后取得 `git rev-parse HEAD` 的 40 位 SHA，回读公开内容核对；在该 SHA 的全新 checkout 运行验证 CI。记录必须对应被引用版本。

## 4. 官方 catalog-only PR

目标 `TheJustinSunPrize/awards:main`；head `CHENLexiao8848:codex/jsp-000637-proof-evidence`。从最新官方 main 建分支，避免夹带其他题。先查已有同一贡献 PR，有则更新，不重复创建。

仅修改 `problems/catalog-0601-0700.md` 中637的 `Lean proof`、`Attribution basis`。引用原 plby 完整证明和本次版本，原作者归属不变；资格和索引字段由维护者审核后协调。

在官方仓库 checkout 运行：

```powershell
python -m pip install -r requirements.txt
python scripts/manage.py validate
python scripts/manage.py links
python scripts/manage.py build
python scripts/manage.py check
python scripts/manage.py history --base <实际官方40位SHA>
python -m unittest discover -s tests -v
```

检查生成 JSON 是否由本次修改引起；纯 catalog 引用一般不改变候选／授奖 JSON。最终 diff 只含获准变更。按最新 PR 模板选择 Lean 信息，填写真实 repository/branch/SHA、三问对应、作者、复现和 CI 链接，引用 Issue #19。

## 5. 审核与完成标准

保存源码 URL、源码 SHA、PR URL、PR head SHA、CI 结果。失败在同一 PR 修复，源码变化重新验证并更新 SHA。

- **已提交**：公开源码可访问，官方 PR 已创建，信息与 SHA 一致。
- **审核通过**：维护者实质确认完整范围、归属和复现；CI 绿色本身不代表数学认证。
- **候选／获奖**：以官方候选记录、身份确认、正式公告为准。PR、合并、Eligible 标记均不保证获奖。

本次先登记证据。维护者认可存在可评估贡献后，再按 [Recommend a recipient](https://github.com/TheJustinSunPrize/awards/blob/main/.github/ISSUE_TEMPLATE/recommend-recipient.yml) 申请真实贡献评估；未完成书面确认使用 `RECIPIENT-JSP-000637-A` 占位，不公开私人材料、不预设奖金。
