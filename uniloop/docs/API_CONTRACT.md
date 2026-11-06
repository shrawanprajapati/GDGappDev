# Mock API Contract

| Method | Resource | Request | Response |
| --- | --- | --- | --- |
| GET | `/projects` | filters | project list |
| POST | `/projects` | project fields | project |
| POST | `/projects/{id}/applications` | student/team and cover note | application |
| PATCH | `/applications/{id}` | status and note | application |
| POST | `/teams/{id}/invites` | email | invitation |
| POST | `/notifications` | userId, type, text, route | notification |
| POST | `/reports` | reporter, target, reason | report |

These endpoints document the shape a future backend can replace; the current
app uses local MockStore methods only.
