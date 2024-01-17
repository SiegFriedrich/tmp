
dotnet ef
You must install or update .NET to run this application.

The following frameworks were found:
  6.0.25 at [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  8.0.0 at [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]


private string GenerateJwtToken()
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);
            var sub = "BV0183202";
            var TIME_SPAN = 24;

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Iat, DateTime.Now.ToString()),
                new Claim(JwtRegisteredClaimNames.Sub, sub),
                new Claim(JwtRegisteredClaimNames.Exp, TIME_SPAN.ToString()),
            };

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims,
                expires: DateTime.Now.AddHours(TIME_SPAN),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

The type or namespace name 'VisualStudio' does not exist in the namespace 'Microsoft' (are you missing an assembly reference?)
