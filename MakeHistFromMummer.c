void MakeHistFromMumm()
{
	string line,foo;
	long long int L;
	ifstream MummerFile("Res.mumm");
	getline(MummerFile,line);
	fstream OutFile("ResHist.mumm",ios::out);
	OutFile<<line<<endl;
	map<unsigned ,unsigned long long int>  MLD;
	while (!(MummerFile.eof()))
	{
		getline(MummerFile,line);
		if (!(line.find('>')<line.size()))
		{
			istringstream iss(line);
			iss>>foo;iss>>foo;iss>>L;
			MLD[L]++;
		}
	}

	for (map<unsigned ,unsigned long long int>::iterator  itMLD=MLD.begin();itMLD!=MLD.end();itMLD++)
	{
		OutFile<<(*itMLD).first<<" "<<(*itMLD).second<<endl;
	}
	MummerFile.close();
	OutFile.close();
}

